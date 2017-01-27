type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

structure M = SplayMapFn(struct type ord_key = string val compare = String.compare end);

(*				  *
 * Keyword Tokens *
 *   			  *)

val constructorMap = foldl (fn ((k, v), m) => M.insert (m, k, v)) M.empty [ ("type", Tokens.TYPE),
																			("var", Tokens.VAR),
																			("function", Tokens.FUNCTION),
																			("break", Tokens.BREAK),
																			("of", Tokens.OF),
																			("end", Tokens.END),
																			("in", Tokens.IN),
																			("nil", Tokens.NIL),
																			("let", Tokens.LET),
																			("do", Tokens.DO),
																			("to", Tokens.TO),
																			("for", Tokens.FOR),
																			("while", Tokens.WHILE),
																			("else", Tokens.ELSE),
																			("then", Tokens.THEN),
																			("if", Tokens.IF),
																			("array", Tokens.ARRAY)];

fun keywordIdToken (s, pos) = case M.find (constructorMap, s) of
								 SOME f => f (pos, pos + String.size s)
							   | NONE => Tokens.ID(s, pos, pos + String.size s);

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end



%%
%%

\n									=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
" "                                 => (linePos := yypos + 1 :: !linePos; continue());
\t									=> (linePos := yypos + 4 :: !linePos; continue());

("_main")|([a-zA-Z][a-zA-Z0-9_]*) 	=> (keywordIdToken (yytext, yypos));
(["].*["])							=> (Tokens.STRING(yytext, yypos, yypos + String.size yytext));


([+-]?[1-9]\d*|0) 	 	 => (case Int.fromString yytext of
									SOME i => (Tokens.INT(i, yypos, yypos + String.size yytext))
								  | NONE   => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue()));

& => (Tokens.AND(yypos, yypos+1));
\| => (Tokens.OR(yypos, yypos+1));
\>= => (Tokens.GE(yypos, yypos+1));
\> => (Tokens.GT(yypos, yypos+1));
\<= => (Tokens.LE(yypos, yypos+1));
\< => (Tokens.LT(yypos, yypos+1));
!= => (Tokens.NEQ(yypos, yypos+1));
= => (Tokens.EQ(yypos, yypos+1));
\/ => (Tokens.DIVIDE(yypos, yypos+1));
\* => (Tokens.TIMES(yypos, yypos+1));
- => (Tokens.MINUS(yypos, yypos+1));
\+ => (Tokens.PLUS(yypos, yypos+1));
\. => (Tokens.DOT(yypos, yypos+1));
\{ => (Tokens.LBRACE(yypos, yypos+1));
\} => (Tokens.RBRACE(yypos, yypos+1));
\[ => (Tokens.LBRACK(yypos, yypos+1));
\] => (Tokens.RBRACK(yypos, yypos+1));
\( => (Tokens.LPAREN(yypos, yypos+1));
\) => (Tokens.RPAREN(yypos, yypos+1));
\; => (Tokens.SEMICOLON(yypos, yypos+1));

: => (Tokens.COLON(yypos, yypos+1));
, => (Tokens.COMMA(yypos, yypos+1));
:= => (Tokens.ASSIGN(yypos, yypos+2));


.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

structure M = SplayMapFn(struct type ord_key = string val compare = String.compare end);

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
																			("array", Tokens.ARRAY)]

fun keywordIdToken (s, pos) = case M.find (constructorMap, s) of
								 SOME f => f (p0, p0 + String.size s)
							   | NONE => Tokens.ID(s, p0, p0 + String.size s)

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end


%%
%%
\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
","	=> (Tokens.COMMA(yypos,yypos+1));
var  	=> (Tokens.VAR(yypos,yypos+3));
"123"	=> (Tokens.INT(123,yypos,yypos+3));
.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

(_main)|([a-zA-Z][a-zA-Z0-9_]*) => keywordIdToken (yytext, yypos)

& => (Tokens.OR(yypos,yypos+1));
| => (Tokens.AND(yypos,yypos+1));
>= => (Tokens.GE(yypos,yypos+1));
> => (Tokens.GT(yypos,yypos+1));
<= => (Tokens.LE(yypos,yypos+1));
< => (Tokens.LT(yypos,yypos+1));
!= => (Tokens.NEQ(yypos,yypos+1));
= => (Tokens.EQ(yypos,yypos+1));
/ => (Tokens.DIVIDE(yypos,yypos+1));
* => (Tokens.TIMES(yypos,yypos+1));
- => (Tokens.MINUS(yypos,yypos+1));
+ => (Tokens.PLUS(yypos,yypos+1));
\. => (Tokens.DOT(yypos,yypos+1));

{ => (Tokens.RBRACE(yypos,yypos+1));
} => (Tokens.LBRACE(yypos,yypos+1));
[ => (Tokens.RBRACK(yypos,yypos+1));
] => (Tokens.LBRACK(yypos,yypos+1));
( => (Tokens.RPAREN(yypos,yypos+1));
) => (Tokens.LPAREN(yypos,yypos+1));
; => (Tokens.SEMICOLON(yypos,yypos+1));
: => (Tokens.SEMICOLON(yypos,yypos+1));
, => (Tokens.SEMICOLON(yypos,yypos+1));


val STRING: (string) *  linenum * linenum -> token
[+|-](0|[1-9])[0-9]*\.?[0-9]*
val INT: (int) *  linenum * linenum -> token

val EOF:  linenum * linenum -> token

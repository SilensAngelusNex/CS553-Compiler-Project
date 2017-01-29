type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos

val commentStack : int list ref = ref [];

val str: string ref    = ref ""

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

val controlCharMap = foldl (fn ((k, v), m) => M.insert (m, k, v)) M.empty [ ("\\^@", "\^@"),
																			("\\0" , "\^@"),
																			("\\^A", "\^A"),
																			("\\^B", "\^B"),
																			("\\^C", "\^C"),
																			("\\^D", "\^D"),
																			("\\^E", "\^E"),
																			("\\^F", "\^F"),
																			("\\^G", "\^G"),
                                                                            ("\\a", "\^G"),
																			("\\^H", "\^H"),
                                                                            ("\\b", "\^H"),
																			("\\^I", "\^I"),
                                                                            ("\\t", "\^I"),
																			("\\^J", "\^J"),
                                                                            ("\\n", "\^J"),
																			("\\^K", "\^K"),
                                                                            ("\\k", "\^V"),
																			("\\^L", "\^L"),
                                                                            ("\\f", "\^L"),
																			("\\^M", "\^M"),
                                                                            ("\\r", "\^M"),
																			("\\^N", "\^N"),
																			("\\^O", "\^O"),
                                                                            ("\\^P", "\^P"),
																			("\\^Q", "\^Q"),
																			("\\^R", "\^R"),
																			("\\^S", "\^S"),
																			("\\^T", "\^T"),
																			("\\^U", "\^U"),
																			("\\^V", "\^V"),
																			("\\^W", "\^W"),
                                                                            ("\\^X", "\^X"),
																			("\\^Y", "\^Y"),
																			("\\^Z", "\^Z"),
                                                                            ("\\^]", "\^]"),
                                                                            ("\\^\\", "\^\"),
                                                                            ("\\^[", "\^["),
                                                                            ("\\e", "\^["),
                                                                            ("\\^^", "\^^"),
                                                                            ("\\^_", "\^_"),
                                                                            ("\\\\", "\\"),
                                                                            ("\\\"", "\"")];

fun keywordIdToken (s, pos) = case M.find (constructorMap, s) of
								 SOME f => f (pos, pos + String.size s)
							   | NONE => Tokens.ID(s, pos, pos + String.size s);

fun appendAsciiInt v = if v >= 0 andalso v <= 255
                       then
                            let val asciiChar = chr v
                                val strVal = Char.toString asciiChar
                                val r = !str
                            in
                                str:= String.concat [r, strVal]
                            end
                       else ();

fun eof() =
    let val pos = hd(!linePos)
        val stack = !commentStack
    in
        case stack of
            [] => ()
          | (a::_) => ErrorMsg.error a ("Unclosed Comment beginning at " ^ (Int.toString a));
        commentStack:= [];
        Tokens.EOF(pos,pos)
    end;

%%
%s COMMENT STRING;
digit=[0-9];
%%

<INITIAL>\n									=> (lineNum := !lineNum + 1;
                                                linePos := yypos :: !linePos;
                                                continue()
                                                );

<INITIAL>[ ]                                => (linePos := yypos + 1 :: !linePos;
                                                continue()
                                                );

<INITIAL>\t									=> (linePos := yypos + 4 :: !linePos;
                                                continue()
                                                );

<INITIAL>(_main)|([a-zA-Z][a-zA-Z0-9_]*) 	=> (keywordIdToken (yytext, yypos));

<INITIAL>\"                                => (YYBEGIN STRING; str:= "";
                                                continue()
                                               );

<INITIAL>([-]?[1-9]\d*|0) 	 	            => (case Int.fromString yytext of
									               SOME i => (Tokens.INT(i, yypos, yypos + String.size yytext))
                                                   | NONE   => (ErrorMsg.error yypos ("illegal character " ^ yytext);
                                                continue())
                                                );

<INITIAL>\/\*                                => (YYBEGIN COMMENT;
                                                 commentStack:= (yypos - 2)::(!commentStack);
                                                 continue()
                                                );


<INITIAL>&                                   => (Tokens.AND(yypos, yypos+1));
<INITIAL>\|                                  => (Tokens.OR(yypos, yypos+1));
<INITIAL>\>=                                 => (Tokens.GE(yypos, yypos+2));
<INITIAL>\>                                  => (Tokens.GT(yypos, yypos+1));
<INITIAL>\<=                                 => (Tokens.LE(yypos, yypos+2));
<INITIAL>\<                                  => (Tokens.LT(yypos, yypos+1));
<INITIAL>!=                                  => (Tokens.NEQ(yypos, yypos+2));
<INITIAL>=                                   => (Tokens.EQ(yypos, yypos+1));
<INITIAL>\/                                  => (Tokens.DIVIDE(yypos, yypos+1));
<INITIAL>\*                                  => (Tokens.TIMES(yypos, yypos+1));
<INITIAL>-                                   => (Tokens.MINUS(yypos, yypos+1));
<INITIAL>\+                                  => (Tokens.PLUS(yypos, yypos+1));
<INITIAL>\.                                  => (Tokens.DOT(yypos, yypos+1));
<INITIAL>\{                                  => (Tokens.LBRACE(yypos, yypos+1));
<INITIAL>\}                                  => (Tokens.RBRACE(yypos, yypos+1));
<INITIAL>\[                                  => (Tokens.LBRACK(yypos, yypos+1));
<INITIAL>\]                                  => (Tokens.RBRACK(yypos, yypos+1));
<INITIAL>\(                                  => (Tokens.LPAREN(yypos, yypos+1));
<INITIAL>\)                                  => (Tokens.RPAREN(yypos, yypos+1));
<INITIAL>\;                                  => (Tokens.SEMICOLON(yypos, yypos+1));

<INITIAL>:                                   => (Tokens.COLON(yypos, yypos+1));
<INITIAL>,                                   => (Tokens.COMMA(yypos, yypos+1));
<INITIAL>:=                                  => (Tokens.ASSIGN(yypos, yypos+2));

<INITIAL>.                                   => (ErrorMsg.error yypos ("illegal character " ^ yytext);
                                                 continue()
                                                 );


<COMMENT>\/\*                                => (commentStack:= yypos::(!commentStack);
                                                 continue()
                                                 );

<COMMENT>\*\/                                => (case !commentStack of
                                                    []     => ()
                                                  | (_::t) => commentStack:= t;

                                                 case !commentStack of
                                                    [] => YYBEGIN INITIAL
                                                   | _ => ();

                                                 continue()
                                                );

<COMMENT>[\t| |\n]                           => (continue());

<COMMENT>.                                   => (continue());

<STRING>\"                                   => (YYBEGIN INITIAL;
                                                 Tokens.STRING(!str, yypos + 1 - String.size (!str), yypos + 1)
                                                );


<STRING>\n|\t                                => (ErrorMsg.error yypos ("Illegal character in string " ^ yytext);
                                                 continue()
                                                );

<STRING>(\\\^.)|(\\.)                        => (case M.find (controlCharMap, yytext) of
                                                 SOME txt => str:= String.concat [!str, txt]
                                               | NONE     => ErrorMsg.error yypos ("Illegal escape character " ^ yytext);

                                                 continue()
                                                );

<STRING>\\[0-9][0-9][0-9]                   => (let val text = substring(yytext,1,3)
                                                     val intVal = valOf (Int.fromString text)

                                                in
                                                    appendAsciiInt intVal;
                                                    continue()
                                                end
                                                );

<STRING>\\[\t\n ]+\\                         => (continue());

<STRING>.                                    => (str:= String.concat [!str, yytext];
                                                 continue()
                                                );

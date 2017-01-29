exception BadResult;

CM.make "Lexer/sources.cm";

fun compare ([], []) = true
    |   compare (x::xs, y::ys) = (x = y) andalso compare(xs,ys)
    |   compare (_, _) = false


(* Test.tig *)

val expectedResult = ["EOF   221","OR   220","ID(_main)     213","END   208","RPAREN   206", "INT(1)   205","COMMA   203","STRING(foo)     200","LPAREN   197",
"ID(print_conditional)     180","IN   176","RPAREN   174"]

val actualResult = Parse.parseToList "Tests/LexerTests/test1.tig";

if compare(expectedResult, actualResult) then () else raise BadResult;

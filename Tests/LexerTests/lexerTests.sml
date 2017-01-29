exception BadResult;

CM.make "Lexer/sources.cm";

val testFiles = [

("Tests/LexerTests/test1.tig",
["EOF   60","LET   28","LET   11","LET   2"]),

("Tests/LexerTests/test2.tig",
["EOF   44","STRING({)     43","STRING(\^@)     36","STRING(\")     30",
"STRING(Hello World)     15","STRING(a\t\n)     9","STRING()     4"]),

("Tests/LexerTests/test3.tig",
["EOF   98","RPAREN   97","ID(x)     96","TIMES   94","ID(ans)     90",
"COMMA   88","INT(~1)   86","ID(x)     85","LPAREN   84","ID(fact_tail)     74",
"GT   72","EQ   71","RPAREN   69","ID(ans)     66","COMMA   65","ID(x)     64",
"LPAREN   63","OR   61","ID(ans)     49","GT   47","EQ   46","RPAREN   44",
"ID(ans)     41","COMMA   40","INT(0)   39","LPAREN   38","OF   27",
"ID(t)     25","ID(case)     20","EQ   18","ID(t)     16","ID(fact_tail)     6","ID(fun)     2"])

]

fun compare ([], []) = true
    |   compare (x::xs, y::ys) = (x = y) andalso compare(xs,ys)
    |   compare (a, b) = false;

fun executeTests tests = map (fn (test, eRes) => (test, compare(eRes, Parse.parseToList test))) tests;

val results = executeTests testFiles;

val result = foldl (fn ((_, res), acc) => if res then acc else raise BadResult) true results;

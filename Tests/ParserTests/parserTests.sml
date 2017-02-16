exception BadParseResult;

CM.make "Parser/sources.cm";

val testLocation = "Tests/ParserTests/"
val resultLocation = "Tests/ParserTests/"
val testFiles = [

("test1", ["OpExp(PlusOp,", "IntExp(4),", "IfExp(", "IntExp(0),", "IntExp(2),", "IntExp(6)))"]),

("test2", ["SeqExp[", "AssignExp(", "SimpleVar(a),", "IntExp(5)),", "OpExp(PlusOp,", "VarExp(", "SimpleVar(a)),", "IntExp(1))]"]),

("test3", ["LetExp([", "VarDec(a,true,NONE,", "IntExp(5)),", "FunctionDec[", "(f,[],", "SOME(int),", "CallExp(g,[", "VarExp(", "SimpleVar(a))])),", "(g,[", "(i,true,int)],", "NONE,", "CallExp(f,[]))]],", "SeqExp[", "CallExp(f,[])])"]),

("test4", ["LetExp([],", "SeqExp[", "NilExp,", "IntExp(1),", "SeqExp[", "IntExp(2),", "IntExp(3)],", "SeqExp[", "IntExp(2),", "IntExp(3),", "IntExp(4)]])"]),

("test5", ["AssignExp(", "SimpleVar(x),", "OpExp(PlusOp,", "IntExp(5),", "IntExp(4)))"])
];

fun printStrList strs = app (fn i => print(i ^ ", ")) strs;

fun compare ([], []) = true
    |   compare (x::xs, y::ys) = (x = y) andalso compare(xs,ys)
    |   compare (a, b) = false;

fun readFile (file: string) =
    let val words = String.tokens Char.isSpace o TextIO.inputAll
        val ins = TextIO.openIn file
    in
        words ins
    end
    handle Io => []

fun pAbsyn (output_file, absyn) = PrintAbsyn.print (TextIO.openOut output_file, absyn);

fun testFile (test, eRes) =
    let val testFile = testLocation ^ test ^ ".tig"
        val absyn = Parse.parse testFile
        val file = resultLocation ^ test ^ "_result.txt"
        val r = pAbsyn(file, absyn)
        val aRes = readFile file
    in
        (test, compare(eRes, aRes))
    end;

fun executeTests tests = map testFile tests;

val results = executeTests testFiles;

val result = foldl (fn ((_, res), acc) => if res then acc else raise BadParseResult) true results;

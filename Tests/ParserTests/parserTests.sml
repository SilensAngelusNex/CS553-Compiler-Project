exception BadParseResult;

CM.make "Parser/sources.cm";

val testLocation = "Tests/ParserTests/"
val resultLocation = "Tests/ParserTests/"
val testFiles = [("test1", "OpExp(PlusOp,\n IntExp(4),\n SeqExp[\n  IfExp(\n   IntExp(0),\n   IntExp(2),\n   IntExp(6))])\n")];

fun pAbsyn (test, absyn) = PrintAbsyn.print ((TextIO.openOut test), absyn);


fun compare (x,y) = x = y;

fun readFile (file: string): string = TextIO.inputAll (TextIO.openIn file);

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

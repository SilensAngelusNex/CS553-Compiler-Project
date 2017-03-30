CM.make "../../IR/sources.cm";

fun run fileName =
	let
		val result = (print ("Running test: \t" ^ fileName ^ "\n"); Main.main (fileName ^ ".tig"))
	in
		print ("Done test: \t" ^ fileName ^ "\n\n\n\n")
	end

	(*
	let
		val out = TextIO.openOut (fileName ^ ".a")
	in
		TextIO.stdOut := out;
		Main.main (fileName ^ ".tig")
	end
	*)

val testList = [
	"test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9", "test10",
	"test11", "test12", "test13", "test14", "test15", "test16", "test17", "test18", "test19", "test20",
	"test21", "test22", "test23", "test24", "test25", "test26", "test27", "test28", "test29", "test30",
	"test31", "test32", "test33", "test34", "test35", "test36", "test37", "test38", "test39", "test40",
	"test41", "test42", "test43", "test44", "test45", "test46", "test47", "test48", "test49",
	"queens","merge"
]

fun runAll l = foldl (fn (s, ()) => (run s; ())) () l

fun runTests () = runAll testList

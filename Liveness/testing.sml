structure Test =
struct
	fun run s = Main.compile ("../Tests/IRTests/test" ^ (Int.toString s) ^ ".tig")

	fun runAll (a::l) = (run a; runAll l)
	  | runAll ([]) = ()

	val allTests = [1, 2, 3, 4, 5, 6, 7, 8, 12, 27, 30, 37, 41, 43, 44, 46, 48]

	fun doTests () = runAll allTests
end

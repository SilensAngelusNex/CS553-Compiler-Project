structure Main : sig val main : string -> unit end =
struct
	fun main filename =
	 	let
			val tree = Parse.parse filename
			val IR = Semant.transProg tree
		in
		()
		end
end

structure Main : sig val main : string -> unit end =
struct
	fun main filename =
	 	let
			val tree = Parse.parse filename
		in
		Semant.transProg tree
		end
end

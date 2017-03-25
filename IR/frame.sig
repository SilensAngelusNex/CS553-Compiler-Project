signature FRAME =
sig
	type frame
	type access
	datatype frag = PROC of {body: Tree.stm, frame: frame}
				  | STRING of Temp.label * string
	val FP : Temp.temp
	val wordSize: int
	val exp : access -> Tree.exp -> Tree.exp
	val newFrame  : {name: Temp.label, formals: bool list} -> frame
	val formals : frame -> access list
	val allocTemp : frame -> Temp.temp
	val allocLocal : frame -> bool -> access
	val externalCall : string * Tree.exp list -> Tree.exp
	val RV : Temp.temp
	val procEntryExit1 : (frame * Tree.stm) -> Tree.stm

	val printAccess : access -> unit
end

signature FRAME =
sig
	type frame
	type access
	type register
	structure TM : ORD_MAP
	datatype frag = PROC of {body: Tree.stm, frame: frame}
				  | STRING of Temp.label * string

	val FP : Temp.temp
	val R0 : Temp.temp
	val SP : Temp.temp
	val V0 : Temp.temp
	val V1 : Temp.temp
	val GP : Temp.temp
	val RA : Temp.temp
	val A0 : Temp.temp
	val A1 : Temp.temp
	val A2 : Temp.temp
	val A3 : Temp.temp

	val callersaves : Temp.temp list

	val unusableRegs : Temp.temp list
	val usableRegs : Temp.temp list

	val string : (Temp.label * string) -> string
	val name : frame -> string
	val label : frame -> Temp.label
	val wordSize: int
	val exp : access -> Tree.exp -> Tree.exp
	val newFrame  : {name: Temp.label, formals: bool list} -> frame
	val formals : frame -> access list
	val allocTemp : frame -> Temp.temp
	val allocLocal : frame -> bool -> access
	val externalCall : string * Tree.exp list -> Tree.exp
	val procEntryExit1 : (frame * Tree.stm) -> Tree.stm
	val procEntryExit2 : frame * Assem.instr list -> Assem.instr list
	val procEntryExit3 : Symbol.symbol * 'a -> {prolog: string, body: 'a, epilog: string}
	val tempMap : string TM.map
	val tempName : Temp.temp -> string

end

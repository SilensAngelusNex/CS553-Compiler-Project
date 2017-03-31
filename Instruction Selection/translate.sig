signature TRANSLATE =
sig
	type exp
	type level
	type access
	val outermost : level
	val newLevel : {parent: level, name: Temp.label, formals: bool list} -> level
	val leaveLevel : level -> level
	val formals : level -> access list
	val allocLocal: level -> bool -> access
	val transSimpleVar : access option * level -> exp
	val procEntryExit : {level: level, body: exp} -> unit
	structure F : FRAME
	val getResult : unit -> F.frag list
	val frag: level * Tree.stm -> F.frag
	val getLevelInfo : level -> access list * Temp.label

	val transOP : Absyn.oper * exp * exp * level -> exp
	val transSeq : exp list * level -> exp
	val transLet : exp list * exp * level -> exp
	val transRec : exp list * level -> exp
	val transArray : exp * exp * level -> exp
	val transAssign : exp * exp * level -> exp
	val transBreak : Temp.label -> exp
	val transBody :  exp * level -> exp
	val transProc :  exp * level -> exp
	val transNil : unit -> exp
	val transInt : int -> exp
	val transString : string -> exp
	val transCall : Temp.label * exp list * level -> exp
	val transFor : exp * exp * exp * Temp.label * level -> exp
	val transWhile : exp * exp * Temp.label * level -> exp
	val transIf : exp * exp * exp option * level -> exp
	val transArrayVar : exp * exp * level -> exp
	val transRecordVar : exp * int * level -> exp
	val beginLoop : unit -> Temp.label

	val treeStm : exp -> Tree.stm
end

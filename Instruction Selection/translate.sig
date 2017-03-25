signature TRANSLATE =
sig
	type exp
	type level
	type access
	val outermost : level
	val newLevel : {parent: level, name: Temp.label, formals: bool list} -> level
	val leaveLevel : unit -> level
	val formals : level -> access list
	val allocLocal: level -> bool -> access
	val transSimpleVar : access option * level -> exp
	val procEntryExit : {level: level, body: exp} -> unit
	structure F : FRAME
	val getResult : unit -> F.frag list
	val fragList : F.frag list ref

	val transOP : Absyn.oper * exp * exp -> exp
	val transSeq : exp list -> exp
	val transLet : exp list * exp -> exp
	val transRec : exp list -> exp
	val transArray : exp * exp -> exp
	val transAssign : exp * exp -> exp
	val transBreak : Temp.label -> exp
	val transBody :  exp -> exp
	val transNil : unit -> exp
	val transInt : int -> exp
	val transString : string -> exp
	val transCall : Temp.label * exp list -> exp
	val transFor : exp * exp * exp * Temp.label -> exp
	val transWhile : exp * exp * Temp.label -> exp
	val transIf : exp * exp * exp option -> exp
	val transArrayVar : exp * exp -> exp
	val transRecordVar : exp * int -> exp
	val beginLoop : unit -> Temp.label

	val treeStm : exp -> Tree.stm
end

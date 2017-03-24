structure MIPSFrame :> FRAME =
struct

	datatype access = InFrame of int
				| InReg of Temp.temp

	type frame = Temp.label * access list ref * int ref

	datatype frag = PROC of {body: Tree.stm, frame: frame}
				  | STRING of Temp.label * string

	val FP = Temp.newtemp ()

	val wordSize = 4

	fun externalCall (s, args) = T.CALL(T.NAME(Temp.namedLabel s), args)

	fun exp InFrame(k) exp: Tree.exp = Tree.MEM(Tree.BINOP(Tree.PLUS, exp, CONST(k))
	  | exp InReg(t) _: Tree.exp = Tree.TEMP(t)

	fun formals (_, a, _): access list = !a

	fun putInReg (name, alist, size) = 	let
											val result = InReg(Temp.newtemp ())
										in
											alist := !alist@[result];
											result
										end

	fun allocLocal (name, alist, size) true  = let
												  val result = InFrame(!size * 4)
											  in
											      alist := !alist@[result];
												  size := !size + 1;
												  result
											  end

	  | allocLocal f false = putInReg f

	fun allocLocals f (i, b::l) = (case i < 4 of
									true	=> (putInReg f		; allocLocals f (i + 1, l))
								  | false 	=> (allocLocal f b	; allocLocals f (i + 1, l)))

	  | allocLocals f (i, [])   = f

	fun newFrame {name=name, formals=blist} = let
												  val f = (name, ref [], ref 0)
												  val result = allocLocals f (0, blist)
											  in
												  result
											  end

	fun procEntryExit1 (frame, body) = body
end

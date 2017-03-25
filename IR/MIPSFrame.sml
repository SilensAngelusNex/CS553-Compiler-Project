structure MIPSFrame :> FRAME =
struct

	datatype access = InFrame of int
				| InReg of Temp.temp

	type frame = Temp.label * access list ref * int ref

	datatype frag = PROC of {body: Tree.stm, frame: frame}
				  | STRING of Temp.label * string

	val FP = Temp.newtemp ()
	val RV = Temp.newtemp ()

	val wordSize = 4

	fun printAccess (InFrame(i)) = (print "Frame: "; print (Int.toString i); print "\n")
	  | printAccess	(InReg(t)) = (print "Temp: "; print (Int.toString t); print "\n")

	fun externalCall (s, args) = Tree.CALL(Tree.NAME(Temp.namedlabel s), args)

	fun exp (InFrame(k)) exp = Tree.MEM(Tree.BINOP(Tree.PLUS, exp, Tree.CONST(k)))
	  | exp (InReg(t)) _ = Tree.TEMP(t)

	fun formals (_, a, _): access list = !a


	fun allocTemp (_, alist, _) = let
											val result = Temp.newtemp ()
										in
											alist := !alist@[InReg(result)];
											result
										end

	fun allocLocal (name, alist, size) true  = let
												  val result = InFrame(!size * 4)
											  in
											  	  print "frame alloc loc\n";
											      alist := !alist@[result];
												  size := !size + 1;
												  result
											  end

	  | allocLocal f false = (print "frame alloc temp\n"; InReg(allocTemp f))

	fun allocLocals f (i, b::l) = (case i < 4 of
									true	=> (allocTemp f		; allocLocals f (i + 1, l))
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

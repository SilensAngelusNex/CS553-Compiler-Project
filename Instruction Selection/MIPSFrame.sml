structure MIPSFrame :> FRAME =
struct

	datatype access = InFrame of int
				| InReg of Temp.temp

	type frame = Temp.label * access list ref * int ref

	type register = Temp.temp * string

	datatype frag = PROC of {body: Tree.stm, frame: frame}
				  | STRING of Temp.label * string

	fun regTemps l = (map (fn (name) => (Temp.newtemp (), name)) l)
	fun getTemps l = (map (fn (temp, name) => temp) l)

	val specialregs = regTemps ["$zero", "$at", "$v0", "$v1", "$gp", "$sp", "$fp", "$ra"]
	val argregs = regTemps ["$a0", "$a1", "$a2", "$a3"]
	val callersaves = regTemps ["t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"]
	val calleesaves = regTemps ["s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7"]



	val tempMap = foldl (fn ((temp, name), table) => Temp.Table.enter (table, temp, (temp, name)))
					(Temp.Table.empty)
					(specialregs@argregs@callersaves@calleesaves)

	val R0 = case List.nth (specialregs, 0) of (temp, name) => temp
	val V0 = case List.nth (specialregs, 2) of (temp, name) => temp
	val V1 = case List.nth (specialregs, 3) of (temp, name) => temp
	val SP = case List.nth (specialregs, 4) of (temp, name) => temp
	val FP = case List.nth (specialregs, 5) of (temp, name) => temp
	val RV = case List.nth (specialregs, 6) of (temp, name) => temp
	val RA = case List.nth (specialregs, 7) of (temp, name) => temp
	val A0 = case List.nth (argregs, 0) of (temp, name) => temp
	val A1 = case List.nth (argregs, 1) of (temp, name) => temp
	val A2 = case List.nth (argregs, 2) of (temp, name) => temp
	val A3 = case List.nth (argregs, 3) of (temp, name) => temp

	val wordSize = 4

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
											      alist := !alist@[result];
												  size := !size + 1;
												  result
											  end

	  | allocLocal f false = InReg(allocTemp f)

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

	fun procEntryExit2 (frame, body) = body @ [Assem.OPER { assem="",
														src=[R0, RA, SP]@(getTemps calleesaves),
														dst=[],
														jump=SOME([])}]

	fun procEntryExit3 (name, body) =
			{
				prolog="PROCEDURE " ^ Symbol.name name ^ "\n",
				body=body,
				epilog="END " ^ Symbol.name name ^ "\n"
			}

	fun tempName t: string = case Temp.Table.look (tempMap, t) of
							SOME(temp, name) => name
						  | NONE => Temp.makestring t
end

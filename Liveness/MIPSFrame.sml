structure MIPSFrame :> FRAME =
struct

	datatype access = InFrame of int
				| InReg of Temp.temp

	type frame = Temp.label * access list ref * int ref

	type register = Temp.temp * string

	structure K : ORD_KEY =
	struct
		type ord_key = Temp.temp
		val compare = Temp.compare
	end

	structure TM = SplayMapFn(K)

	datatype frag = PROC of {body: Tree.stm, frame: frame}
				  | STRING of Temp.label * string

	fun regTemps l = (map (fn (name) => (Temp.newtemp (), name)) l)
	fun getTemps l = (map (fn (temp, name) => temp) l)

	fun name (t, l, i) = Symbol.name t
	fun label (t, l, i) = t


	val specialregs = regTemps ["$zero", "$at", "$v0", "$v1", "$gp", "$sp", "$fp", "$ra"]
	val argregs = regTemps ["$a0", "$a1", "$a2", "$a3"]
	val callersaves = regTemps ["$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8", "$t9"]
	val calleesaves = regTemps ["$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7"]

	val tempMap = foldl (fn ((temp, name), table) => TM.insert (table, temp, name))
					(TM.empty)
					(specialregs@argregs@callersaves@calleesaves)

	fun tempName t = case TM.find(tempMap, t) of
							SOME(n) => n
							| NONE => Temp.makestring t
 	fun string (lab, str) = lab ^ ":" ^ "\t\t.word\t\t" ^ (Int.toString (String.size str)) ^ "\n\t\t\t.asciiz\t\t" ^ "\"" ^ str ^ "\"\n"

	val R0 = case List.nth (specialregs, 0) of (temp, name) => temp
	val AT = case List.nth (specialregs, 1) of (temp, name) => temp
	val V0 = case List.nth (specialregs, 2) of (temp, name) => temp
	val V1 = case List.nth (specialregs, 3) of (temp, name) => temp
	val GP = case List.nth (specialregs, 4) of (temp, name) => temp
	val SP = case List.nth (specialregs, 5) of (temp, name) => temp
	val FP = case List.nth (specialregs, 6) of (temp, name) => temp
	val RA = case List.nth (specialregs, 7) of (temp, name) => temp
	val A0 = case List.nth (argregs, 0) of (temp, name) => temp
	val A1 = case List.nth (argregs, 1) of (temp, name) => temp
	val A2 = case List.nth (argregs, 2) of (temp, name) => temp
	val A3 = case List.nth (argregs, 3) of (temp, name) => temp

	val unusableRegs = [R0, AT, GP, SP, FP, RA]
	val usableRegs = (getTemps calleesaves)@(getTemps callersaves)@[A0, A1, A2, A3, V0, V1]

	val wordSize = 4

	fun externalCall (s, args) = Tree.CALL(Tree.NAME(Temp.namedlabel s), args)

	fun exp (InFrame(k)) exp = Tree.MEM(Tree.BINOP(Tree.MINUS, exp, Tree.CONST(k)))
	  | exp (InReg(t)) _ = Tree.TEMP(t)

	fun formals (_, a, _): access list = !a
	fun size (_, _, a): int = !a * 4

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

	fun allocArgTemp ((_, alist, _), i) =
		let
			val result = case i of
							0 => A0
						  | 1 => A1
						  | 2 => A2
						  | 3 => A3
						  | _ => Temp.newtemp ()
		in
			alist := !alist@[InReg(result)];
			result
		end

	fun allocLocals f (i, b::l) = (allocLocal f b; allocLocals f (i + 1, l))
	  | allocLocals f (i, [])   = f

	fun clearFormals ((n, a, s), l) = (a := []; s := 0; allocLocals (n, a, s) (0, l))

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

	(*fun tempName t: string = case Temp.Table.look (tempMap, t) of
							SOME(temp, name) => name
						  | NONE => Temp.makestring t*)
end

structure RegAlloc :> ALLOC =
struct

	structure A = Assem
	structure F = MIPSFrame
	structure M = MIPSFrame
	structure I = InterferenceGraph

	structure K1 : ORD_KEY =
	struct
		type ord_key = Temp.temp
		val compare = Temp.compare
	end

	structure K2 : ORD_KEY =
	struct
		type ord_key = I.color
		val compare = I.compare
	end

	structure TM = SplayMapFn(K1)
	structure CM = SplayMapFn(K2)

	fun allocRegs getReg (A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::instrus) = A.OPER{assem=a, dst=map getReg dstLst, src=map getReg srcLst, jump=jmp}::(allocRegs getReg instrus)
	  | allocRegs getReg (A.LABEL{assem=a, lab=label}::instrus) = A.LABEL{assem=a, lab=label}::(allocRegs getReg instrus)
	  | allocRegs getReg (A.MOVE{assem=a, dst=dst, src=src}::instrus) = A.MOVE{assem=a, dst=getReg (dst), src=getReg (src)}::(allocRegs getReg instrus)
	  | allocRegs getReg [] = []

	fun removeRedundantMove (A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::instrus) = A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::(removeRedundantMove instrus)
	  | removeRedundantMove (A.LABEL{assem=a, lab=label}::instrus) = A.LABEL{assem=a, lab=label}::(removeRedundantMove instrus)
	  | removeRedundantMove (A.MOVE{assem=a, dst=dst, src=src}::instrus) = if (print ((Temp.makestring dst) ^ " <-- " ^ (Temp.makestring src) ^ "\n"); dst = src) then (removeRedundantMove instrus) else A.MOVE{assem=a, dst=dst, src=src}::(removeRedundantMove instrus)
	  | removeRedundantMove [] = []

	fun regAlloc (instrus, intergraph) =
		let
			val tempToColorMap = I.graphColor intergraph
			val _ = I.printColorMap tempToColorMap
			val getRegFunc = I.tempToReg tempToColorMap
			val instrus' = allocRegs getRegFunc instrus
			val result = removeRedundantMove instrus'
		in
			result
		end
end

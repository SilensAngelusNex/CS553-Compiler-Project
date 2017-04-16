structure RegAlloc :> ALLOC =
struct

	structure M = MIPSFrame
	structure C = Color

	structure K1 : ORD_KEY =
	struct
		type ord_key = Temp.temp
		val compare = Temp.compare
	end

	structure K2 : ORD_KEY =
	struct
		type ord_key = C.color
		val compare = C.compare
	end

	structure TM = SplayMapFn(K1)
	structure CM = SplayMapFn(K2)


	fun tempToReg (colorToRegMap, tempToColorMap) =
		let
			fun getReg t = case TM.find (tempToColorMap, t) of
							SOME(c) => (case CM.find (colorToRegMap, c) of
											SOME(r) => r
										  | NONE => (print "color not found in color->reg map"; F.R0))
						  | NONE => (print "temp not found in temp->color map"; F.R0)
			fun keySet m = map (fn (a, b) => a) (TM.listItemsi m)
			val tempToRegMap = foldl (fn (t, m) => TM.insert (m, t, (getReg t))) TM.empty (keySet tempToColorMap)
			fun result t = case TM.find (tempToRegMap, t) of
								SOME(r) => r
							  | NONE => (print "temp not found in temp->reg map"; F.R0)
		in
			result
		end


	fun allocRegs getReg (A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::instrus) = A.OPER{assem=a, dst=map getReg dstLst, src=map getReg srcLst, jump=jmp}::(allocRegs instrus)
	  | allocRegs getReg (A.LABEL{assem=a, lab=label}::instrus) = A.LABEL{assem=a, lab=label}::(allocRegs instrus)
	  | allocRegs getReg (A.MOVE{assem=a, dst=dst, src=src}::instrus) = A.MOVE{assem=a, dst=getReg (dst), src=getReg (src)}::(allocRegs instrus)
	  | allocRegs getReg [] = []

	fun removeRedundantMove (A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::instrus) = A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::(removeRedundantMove instrus)
	  | removeRedundantMove (A.LABEL{assem=a, lab=label}::instrus) = A.LABEL{assem=a, lab=label}::(removeRedundantMove instrus)
	  | removeRedundantMove (A.MOVE{assem=a, dst=dst, src=src}::instrus) = if dst = src then (removeRedundantMove instrus) else A.MOVE{assem=a, dst=dst, src=src}::(removeRedundantMove instrus)
	  | removeRedundantMove [] = []

	fun regAlloc (instrus, intergraph) =
		let
			val (tempToColorMap, colorToRegMap) = Color.graphColor intergraph
			val getRegFunc = tempToReg (colorToRegMap, tempToColorMap)
			val instrus' = allocRegs getRegFunc instrus
			val result = removeRedundantMove instrus'
		in
			result
		end
end

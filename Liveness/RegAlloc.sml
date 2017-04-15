structure RegAlloc =
struct
	structure TM = SplayMapFn(K)
	structure CM = SplayMapFn(K)
	structure M = MIPSFrame
	structure I = InterferenceGraph

	datatype graphAction = SIMPLIFY of I.graph * I.node
						 | COALESCE of I.graph * I.node * I.node
						 | UNFREEZE of I.graph * I.node
						 | POTSPILL of I.graph * I.node

	fun graphColor interGraph =
		let
			fun trySimplify interGraph = case I.nextTosimplify interGraph of
											SOME(n) => I.simplify (interGraph, n)
										  | NONE => tryCoalesce interGraph
			and tryCoalesce interGraph = case I.nextToCoalesce interGraph of
											SOME(n1, n2) => I.coalesce (interGraph, n1, n2)
										  | NONE => tryUnFreeze interGraph
			and tryUnFreeze interGraph = case I.nextToUnFreeze interGraph of
											SOME(n) => I.unFreeze (interGraph, n)
										  | NONE => I.potentialSpill interGraph

			fun color interGraph =
				if I.size interGraph > 0
				then
					let
						val action = trySimplify interGraph

				else I.empty, TM.empty, CM.EMPTY

			val interGraph' =

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
		end


	fun allocRegs getReg (A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::instrus) = A.OPER{assem=a, dst=map getReg dstLst, src=map getReg srcLst, jump=jmp}::(allocRegs instrus)
	  | allocRegs getReg (A.LABEL{assem=a, lab=label}::instrus) = A.LABEL{assem=a, lab=label}::(allocRegs instrus)
	  | allocRegs getReg (A.MOVE{assem=a, dst=dst, src=src}::instrus) = A.MOVE{assem=a, dst=getReg (dst), src=getReg (src)}::(allocRegs instrus)

	fun removeRedundantMove (A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::instrus) = A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}::(removeRedundantMove instrus)
	  | removeRedundantMove (A.LABEL{assem=a, lab=label}::instrus) = A.LABEL{assem=a, lab=label}::(removeRedundantMove instrus)
	  | removeRedundantMove (A.MOVE{assem=a, dst=dst, src=src}::instrus) = if dst = src then (removeRedundantMove instrus) else A.MOVE{assem=a, dst=dst, src=src}::(removeRedundantMove instrus)

	fun regAlloc (instrus, intergraph) =
		let
			val tempToColorMap, colorToRegMap = graphColor intergraph
			val getRegFunc = tempToReg (colorToRegMap, tempToColorMap)
			val instrus' = allocRegs getRegFunc instrus
			val result = removeRedundantMove instrus'
		in
			result
		end
end

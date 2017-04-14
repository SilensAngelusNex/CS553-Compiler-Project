structure InterferenceGraph : INTERFERENCE_GRAPH =
struct
	type temp = Temp.temp
	datatype color = COLOR of int
				   | BLANK

	structure K : ORD_KEY =
	struct
		type ord_key = temp
		val compare = Temp.compare
	end

	structure G = FuncGraph(K)
	structure M = SplayMapFn(K)
	structure F = MIPSFrame

	type graph = unit G.graph * unit G.graph * color M.map


	val nextColor = ref 1

	val empty = (G.empty, G.empty, M.empty)

	fun newColor () =
		let
			val result =  COLOR(!nextColor)
		in
			nextColor := !nextColor + 1;
			result
		end

	fun itemList (_, _, m) = M.listItemsi m
	fun keyList g = map (fn (a, b) => a) (itemList g)

	fun addTemp ((g1, g2, m), t) = (G.addNode (g1, t, ()), G.addNode (g2, t, ()), M.insert (m, t, BLANK))
	val registersOnly = foldl (fn (t, g) => addTemp (g, t)) empty F.usableRegs

	fun addMove ((g1, g2, m), t1, t2) = (g1, G.addEdge (g2, {from=t2,to=t1}), m)
	fun addInter ((g1, g2, m), t1, t2) = (G.doubleEdge (g1, t1, t2), g2, m)
	fun addEdge (g, t1, t2, true)  = addMove(g, t1, t2)
	  | addEdge (g, t1, t2, false) = addInter(g, t1, t2)

	fun removeNode ((g1, g2, m), t) = (G.removeNode (g1, t), G.removeNode (g2, t), (case M.remove (m, t) of (a, b) => a))
	fun removeNode' ((g1, g2, m), t) = (G.removeNode' (g1, t), G.removeNode' (g2, t), (case M.remove (M.insert (m, t, BLANK), t) of (a, b) => a))

	fun interDegree ((g1, g2, m), t) = G.outDegree (G.getNode(g1, t))
	fun moveDegree ((g1, g2, m), t) = G.inDegree (G.getNode(g2, t))
	fun degree ((g1, g2, s), t) = G.outDegree (G.getNode(g1, t)) + G.degree (G.getNode(g2, t))

	val tempToString = Temp.makestring
	fun colorToString (COLOR(i)) = "COLOR:\t" ^ (Int.toString i)
	  | colorToString (BLANK) = "BLANK"
end

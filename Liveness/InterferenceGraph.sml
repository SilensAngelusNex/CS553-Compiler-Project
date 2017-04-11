structure InterferenceGraph : INTERFERENCE_GRAPH =
struct
	type temp = Temp.temp

	structure K : ORD_KEY =
	struct
		type ord_key = temp
		val compare = Temp.compare
	end

	structure G = FuncGraph(K)
	structure S = SplaySetFn(K)

	type graph = unit G.graph * unit G.graph * S.set
	val empty : graph = (G.empty, G.empty, S.empty)

	fun itemList (g1, g2, s) = S.listItems s

	fun addTemp ((g1, g2, s), t) = (G.addNode (g1, t, ()), G.addNode (g2, t, ()), S.add (s, t))
	fun addMove ((g1, g2, s), t1, t2) = (g1, G.addEdge (g2, {from=t1,to=t2}), s)
	fun addInter ((g1, g2, s), t1, t2) = (G.doubleEdge (g1, t1, t2), g2, s)
	fun addEdge (g, t1, t2, true)  = addMove(g, t1, t2)
	  | addEdge (g, t1, t2, false) = addInter(g, t1, t2)

	fun removeNode ((g1, g2, s), t) = (G.removeNode (g1, t), G.removeNode (g2, t), S.delete (s, t))
	fun removeNode' ((g1, g2, s), t) = (G.removeNode' (g1, t), G.removeNode' (g2, t), S.difference (s, S.singleton t))

end

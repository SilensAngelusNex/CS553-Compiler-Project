structure InterferenceGraph :> INTERFERENCE_GRAPH =
struct
	type temp = Temp.temp

	structure K : ORD_KEY =
	struct
		type ord_key = temp
		val compare = Temp.compare
	end

	structure G = FuncGraph(K)
	structure M = SplayMapFn(K)

	structure F = MIPSFrame
	structure K1 : ORD_KEY =
	struct
		type ord_key = Temp.temp
		val compare = Temp.compare
	end

	datatype color = COLOR of Temp.temp
				   | BLANK

	fun compare (COLOR(t1), COLOR(t2)) = Temp.compare(t1, t2)
	  | compare (_, _) = LESS

	structure K2 : ORD_KEY =
	struct
		type ord_key = color
		val compare = compare
	end

	structure TM = SplayMapFn(K1)
	structure CM = SplayMapFn(K2)
	structure S = SplaySetFn(K2)

	type graph = unit G.graph * unit G.graph * color M.map

    datatype graphAction = SIMPLIFY of graph * Temp.temp
                         | COALESCE of graph * Temp.temp * Temp.temp
                         | UNFREEZE of graph * Temp.temp
                         | POTSPILL of graph * Temp.temp

    val nextColor = ref 0

	val colors = map (fn reg => COLOR(reg)) MIPSFrame.usableRegs

    fun newColor () =
    	let
			val result = List.nth(colors, 0)
    	in
    		nextColor := !nextColor + 1;
    		result
    	end



	val empty = (G.empty, G.empty, M.empty)

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

	fun successors ((g1, g2, m), t) = (G.succs (G.getNode (g1, t)))
	fun predecessors ((g1, g2, m), t) = (G.preds (G.getNode (g1, t)))

	(*fun interDegree ((g1, g2, m), t) =
		case C.getColor ((g1, g2, m), t) of
			BLANK => G.outDegree (G.getNode(g1, t))
		  | COLOR(_) => (case Int.maxInt of SOME(i) => i | NONE => 10000000)*)


	fun moveDegree ((g1, g2, m), t) = G.inDegree (G.getNode(g2, t))
	fun degree ((g1, g2, s), t) = G.outDegree (G.getNode(g1, t)) + G.degree (G.getNode(g2, t))

	fun moveRelated ((g1, g2, m), t) = G.degree (G.getNode(g2, t)) > 0

	val tempToString = Temp.makestring


	fun size (g1, g2, m) = M.numItems m

    (* take out the node *)
	fun simplify (graph, n) = SIMPLIFY(removeNode(graph, n), n)

	fun coalesce (graph, n1, n2) = COALESCE(graph, n1, n2)

	fun unFreeze ((g1, g2, m), t) =
		let
			val succsList: Temp.temp G.edge list = map (fn (s) => {from=t, to=s}) (G.succs (G.getNode (g2, t)))
			val predsList: Temp.temp G.edge list = map (fn (p) => {from=p, to=t}) (G.preds (G.getNode (g2, t)))
			val moveEdges = succsList@predsList
			val g2' = (foldl (fn (e, g) => G.removeEdge (g, e)) g2 moveEdges)
		in
			UNFREEZE((g1, g2', m), t)
		end

	fun pickSpill graph = case keyList (graph) of
							SOME(a::l) => a
							| SOME(_) => Temp.newtemp () (* ERROR *)
							| NONE => Temp.newtemp (); (* ERROR *)

    fun potentialSpill graph =
		let
			val n = pickSpill graph
		in
			POTSPILL(removeNode(graph, n), n)
		end

	(* Find the next node to simplfy *)
	fun nextToSimplify g =
		let
			fun help (t::l) = if degree (g, t) < List.length(MIPSFrame.usableRegs) then SOME(t) else help (l)
			  | help ([]) = NONE
		in
			help (keyList g)
		end

	fun nextToCoalesce g = SOME(Temp.newtemp (), Temp.newtemp ())

	fun nextToUnFreeze g =
		let
			fun help (t::l) = if degree (g, t) < List.length(MIPSFrame.usableRegs) then SOME(t) else help (l)
			  | help ([]) = NONE
		in
			help (keyList g)
		end

    fun graphColor interGraph =
        let
            fun trySimplify interGraph = case nextToSimplify interGraph of
                                            SOME(n) => simplify (interGraph, n)
                                          | NONE => tryCoalesce interGraph
            and tryCoalesce interGraph = case nextToCoalesce interGraph of
                                            SOME(n1, n2) => coalesce (interGraph, n1, n2)
                                          | NONE => tryUnFreeze interGraph
            and tryUnFreeze interGraph = case nextToUnFreeze interGraph of
                                            SOME(n) => unFreeze (interGraph, n)
                                          | NONE => potentialSpill interGraph

			fun getNodesColor (m, nID) = case M.find (m, nID) of
										 	SOME(c) => c
											| NONE => BLANK
			fun getColor ((g1, g2, m), nID) =
				let
					val all = S.addList(S.empty, (map (fn r => COLOR(r)) F.usableRegs))
					val succs = G.succs (G.getNode(g1, nID))
					val preds = G.preds (G.getNode(g1, nID))
					val remaining = foldl (fn (n, s) => S.difference (s, S.singleton(getNodesColor (m, n)))) all succs
					val available = foldl (fn (n, s) => S.difference (s, S.singleton(getNodesColor (m, n)))) remaining preds
					val available: color list = S.listItems(available)
				in
					if List.length(available) > 0
					then
						let
							val c = List.nth(available, 0)
						in
							((g1, g2, TM.insert (m, nID, c)), c)
						end
					else ((g1, g2, TM.insert (m, nID, BLANK)), BLANK)
				end

			fun addColoredNode (originalInterGraph, newInterG, nID): graph * color =
			    let
			        val succs = successors (originalInterGraph, nID)
			        val preds = predecessors (originalInterGraph, nID)
			        val interG = addTemp(newInterG, nID)
					val interG = foldl (fn (t, g) => addInter(g, t, nID)) interG succs
			        val g' = foldl (fn (t, g) => addInter(g, t, nID)) interG preds
					val (g'', color) = getColor (g', nID)
			    in
			         (g'', color) (* Can actually spill !!! have to actually add to graph*)
			    end

            and color interGraph =
                if size interGraph > 0
                then
                    case trySimplify interGraph of
                        SIMPLIFY(g, n)      => let
                                                  val (iGraph, tempToCol) = color g
                                                  val (graph, c) = addColoredNode (interGraph, iGraph, n)
                                                in
                                                    (graph, TM.insert (tempToCol, n, c))
                                                end
                      | COALESCE(g, n1, n2) => color g
                      | UNFREEZE(g, n)      => color g
                      | POTSPILL(g, n)      => let
                                                    val (iGraph, tempToCol) = color g
                                                    val (graph, c) = addColoredNode (interGraph, g, n)
                                                in
                                                    (graph, TM.insert (tempToCol, n, c))
                                                end

                else ((G.empty, G.empty, M.empty), TM.empty)

            val (graph, tempToCol) = color interGraph
        in
            (graph, tempToCol)
        end


    fun colorToString (COLOR(t)) = "COLOR:\t" ^ (Temp.makestring (t))
	  | colorToString (BLANK) = "BLANK"

	fun getColor ((g1, g2, m), t) =
		case M.find (m, t) of
			SOME(COLOR(i)) => COLOR(i)
		  | SOME(BLANK) => BLANK
		  | NONE => (print "Error: finding color of nonexistant node."; BLANK)
end

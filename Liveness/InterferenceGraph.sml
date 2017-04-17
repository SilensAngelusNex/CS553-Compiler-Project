structure InterferenceGraph :> INTERFERENCE_GRAPH =
struct
	type temp = Temp.temp

	datatype color = COLOR of Temp.temp
				   | BLANK

	fun compare (COLOR(t1), COLOR(t2)) = Temp.compare(t1, t2)
	  | compare (_, _) = LESS

	structure K : ORD_KEY =
	struct
		type ord_key = temp
		val compare = Temp.compare
	end

	structure K2 : ORD_KEY =
	struct
		type ord_key = color
		val compare = compare
	end

	structure G = FuncGraph(K)
	structure TM = SplayMapFn(K)
	structure S = SplaySetFn(K2)
	structure F = MIPSFrame

	type graph = unit G.graph * unit G.graph * color TM.map

    datatype graphAction = SIMPLIFY of graph * Temp.temp
                         | COALESCE of graph * Temp.temp * Temp.temp
                         | UNFREEZE of graph * Temp.temp
                         | POTSPILL of graph * Temp.temp
						 | DONE of graph

    val nextColor = ref 0

	val empty = (G.empty, G.empty, TM.empty)

	val colors = map (fn reg => COLOR(reg)) MIPSFrame.usableRegs

    fun newColor () =
    	let
			val result = List.nth(colors, 0)
    	in
    		nextColor := !nextColor + 1;
    		result
    	end

	fun itemList (_, _, m) = TM.listItemsi m
	fun keyList g = map (fn (a, b) => a) (itemList g)

	fun addTemp ((g1, g2, m), t) = (G.addNode (g1, t, ()),
									G.addNode (g2, t, ()),
									case TM.find (m, t) of
										SOME(x) => m
									  | NONE => TM.insert (m, t, BLANK))

	fun addUnusableTemp ((g1, g2, m), t) = (G.addNode (g1, t, ()), G.addNode (g2, t, ()), TM.insert (m, t, COLOR(t)))
	val registersOnly = foldl (fn (t, g) => addTemp (g, t)) empty F.usableRegs

	fun addMove ((g1, g2, m), t1, t2) = (g1, G.addEdge (g2, {from=t2,to=t1}), m)
	fun addInter ((g1, g2, m), t1, t2) = (G.doubleEdge (g1, t1, t2), g2, m)
	fun addEdge (g, t1, t2, true)  = addMove(g, t1, t2)
	  | addEdge (g, t1, t2, false) = addInter(g, t1, t2)

	fun removeNode ((g1, g2, m), t) = (G.removeNode (g1, t), G.removeNode (g2, t), (case TM.remove (m, t) of (a, b) => a))
	fun removeNode' ((g1, g2, m), t) = (G.removeNode' (g1, t), G.removeNode' (g2, t), (case TM.remove (TM.insert (m, t, BLANK), t) of (a, b) => a))

	fun successors ((g1, g2, m), t) = (G.succs (G.getNode (g1, t)))
	fun predecessors ((g1, g2, m), t) = (G.preds (G.getNode (g1, t)))

	fun moveDegree ((g1, g2, m), t) = G.inDegree (G.getNode(g2, t))

	fun checkColor ((g1, g2, m), t) = case TM.find (m, t) of
										SOME(x) => x
									  | NONE => BLANK
	fun interDegree ((g1, g2, m), t) =
		case checkColor ((g1, g2, m), t) of
			BLANK => G.outDegree (G.getNode(g1, t))
		  | COLOR(_) => 10000000

	fun degree ((g1, g2, s), t) = G.outDegree (G.getNode(g1, t)) + G.degree (G.getNode(g2, t))

	fun moveRelated ((g1, g2, m), t) = G.degree (G.getNode(g2, t)) > 0

	val tempToString = Temp.makestring

	fun size (g1, g2, m) = TM.numItems m

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

	fun pickSpill graph =
		let
			val lst = keyList (graph)
			fun getNext (a::l) = (case checkColor(graph, a) of
										COLOR(_) => getNext(l)
									  | BLANK => a
									  )
			  | getNext ([]) = Temp.newtemp () (* ERROR !!!! *)
		in
			getNext (lst)
		end

    fun potentialSpill graph =
		let
			val _ = print "SPILL!"
			val n = pickSpill graph
		in
			POTSPILL(removeNode(graph, n), n)
		end

	fun printColor (g, t) = (case checkColor (g, t) of
								  COLOR(r) => "COLOR(" ^ (Temp.makestring r) ^ ")"
								| BLANK => "BLANK")
	fun printColors g =
		let
			val _ = print "GRAPH: \n"
			val lst = (keyList g)
			fun colorL g (t::l) = (print ("\t" ^ (Temp.makestring t) ^ " has color " ^ (printColor (g, t) ^ "\n")); colorL g l)
			   | colorL g ([]) = print "\n"
		in
			colorL g lst;
			()
		end

	fun printColorMap m = (print "COLOR MAP: \n" ; TM.appi (fn (key, color) =>
						case color of
							COLOR(t) => print ("\t" ^ (Temp.makestring key)  ^ " has COLOR("^ (Temp.makestring t) ^ ")\n")
						  | BLANK => print "\tis blank\n" ) m; ())
	(* Find the next node to simplfy *)
	fun nextToSimplify g =
		let
			fun help (t::l) = let
								val y = interDegree (g, t)
							  in
							  	if y < List.length(MIPSFrame.usableRegs)
								then (print  ("Simplifying node: " ^ (Temp.makestring t) ^ "  which has interdegree " ^ (Int.toString y) ^  " and color " ^ (printColor (g, t)) ^ "\n"); SOME(t))
								else help (l)
							  end
			 | help ([]) = NONE

			 fun checkColored (t::l) = (case checkColor (g, t) of
										   COLOR(_) => (print ("This is alredy colored: " ^ (Temp.makestring t) ^ "\n"); checkColored(l))
										 | BLANK => false)
			   | checkColored ([]) = true

			  val keyl = keyList g

		in
			case help keyl of
				SOME(x) => SOME(SOME(x))
				| NONE => if checkColored(keyl)
						  then SOME(NONE)
						  else NONE
		end

	fun nextToCoalesce g = NONE

	fun nextToUnFreeze g = NONE

	fun getNodesColor (m, nID) = case TM.find (m, nID) of
									SOME(c) => c
									| NONE => BLANK
	fun getColor ((g1, g2, m), nID: K.ord_key) =
		let
			val all = S.addList(S.empty, (map (fn r => COLOR(r)) F.usableRegs))
			val remaining = foldl (fn (n, s) => S.difference (s, S.singleton(getNodesColor (m, n)))) all (G.succs (G.getNode(g1, nID)))
			val available = foldl (fn (n, s) => S.difference (s, S.singleton(getNodesColor (m, n)))) remaining (G.preds (G.getNode(g1, nID)))
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
			val interG = addTemp(newInterG, nID)
			val interG = foldl (fn (t, g) => addInter(g, t, nID)) interG (successors (originalInterGraph, nID))
			val g' = foldl (fn (t, g) => addInter(g, t, nID)) interG (predecessors (originalInterGraph, nID))
			val (g'', color) = getColor (g', nID)
		in
			 (g'', color) (* Can actually spill !!! have to actually add to graph*)
		end

    fun graphColor interGraph =
        let
			val _ = printColors interGraph
            fun trySimplify interGraph = case nextToSimplify interGraph of
                                            SOME(SOME(n)) => simplify (interGraph, n)
										  | SOME(NONE) => DONE(interGraph)
                                          | NONE => tryCoalesce interGraph
            and tryCoalesce interGraph = case nextToCoalesce interGraph of
                                            SOME(n1, n2) => coalesce (interGraph, n1, n2)
                                          | NONE => tryUnFreeze interGraph
            and tryUnFreeze interGraph = case nextToUnFreeze interGraph of
                                            SOME(n) => unFreeze (interGraph, n)
                                          | NONE => potentialSpill interGraph

            fun color interGraph =
                if size interGraph > 0
                then
                    case trySimplify interGraph of
                        SIMPLIFY(g, n)      => let
                                                  val (iGraph, tempToCol) = color g
                                                  val (graph, c) = addColoredNode (interGraph, iGraph, n)
												  val _ = print  ("Just colored node: " ^ (Temp.makestring n) ^ "\n")
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
					  | DONE(g) => ( print "Things are already colored!\n";(g, TM.empty))

                else ((G.empty, G.empty, TM.empty), TM.empty)

            val (graph, tempToCol) = color interGraph
        in
            case graph of
			 (_, _, m) => m
        end


    fun colorToString (COLOR(t)) = "COLOR:\t" ^ (Temp.makestring (t))
	  | colorToString (BLANK) = "BLANK"

	fun getColor ((g1, g2, m), t) =
		case TM.find (m, t) of
			SOME(COLOR(i)) => COLOR(i)
		  | SOME(BLANK) => BLANK
		  | NONE => (print "Error: finding color of nonexistant node."; BLANK)

	fun tempToReg tempToColorMap t = case TM.find (tempToColorMap, t) of
										SOME(c) => ( case c of
														COLOR(r) => (print ("Turning REGISTER: " ^ (Temp.makestring t) ^ " into " ^ (Temp.makestring t) ^ "\n"); r)
													  | BLANK    => (print ("temp: " ^ (Temp.makestring t) ^ " is blank?\n"); F.FP))
									  | NONE => (print ("temp: " ^ (Temp.makestring t) ^ " not found in temp->color map\n"); F.FP)
end

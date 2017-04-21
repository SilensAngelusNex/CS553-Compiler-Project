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
	structure NS = SplaySetFn(K)
	structure F = MIPSFrame

	type graph = unit G.graph * unit G.graph * color TM.map * temp TM.map

    datatype graphAction = SIMPLIFY of graph * Temp.temp
                         | COALESCE of graph * Temp.temp * Temp.temp
                         | UNFREEZE of graph * Temp.temp
                         | POTSPILL of graph * Temp.temp
						 | DONE of graph

    val nextColor = ref 0

	val empty = (G.empty, G.empty, TM.empty, TM.empty)

	val colors = map (fn reg => COLOR(reg)) MIPSFrame.usableRegs

    fun newColor () =
    	let
			val result = List.nth(colors, 0)
    	in
    		nextColor := !nextColor + 1;
    		result
    	end

	fun itemList (_, _, cm, tm) = TM.listItemsi cm
	fun keyList g = map (fn (a, b) => a) (itemList g)

	fun addTemp ((g1, g2, cm, tm), t) = (G.addNode (g1, t, ()),
									G.addNode (g2, t, ()),
									case TM.find (cm, t) of
										SOME(x) => cm
									  | NONE => TM.insert (cm, t, BLANK),
									case TM.find (tm, t) of
  										SOME(x) => tm
  									  | NONE => TM.insert (tm, t, t))

	fun addRegister ((g1, g2, cm, tm), t) = (G.addNode (g1, t, ()), G.addNode (g2, t, ()), TM.insert (cm, t, COLOR(t)), TM.insert (tm, t, t))
	val registersOnly = foldl (fn (t, g) => addRegister (g, t)) empty (F.usableRegs@F.unusableRegs)

	fun addMove ((g1, g2, cm, tm), t1, t2) = (g1, G.addEdge (g2, {from=t2,to=t1}), cm, tm)
	fun addInter ((g1, g2, cm, tm), t1, t2) = (G.doubleEdge (g1, t1, t2), g2, cm, tm)
	fun addEdge (g, t1, t2, true)  = addMove(g, t1, t2)
	  | addEdge (g, t1, t2, false) = addInter(g, t1, t2)

	fun removeNode ((g1, g2, cm, tm), t) = (G.removeNode (g1, t), G.removeNode (g2, t), (case TM.remove (cm, t) of (a, b) => a), (case TM.remove (tm, t) of (a, b) => a))
	fun removeNode' ((g1, g2, cm, tm), t) = (G.removeNode' (g1, t), G.removeNode' (g2, t), (case TM.remove (TM.insert (cm, t, BLANK), t) of (a, b) => a), (case TM.remove (TM.insert (tm, t, t), t) of (a, b) => a))

	fun successors ((g1, g2, cm, tm), t) = (G.succs (G.getNode (g1, t)))
	fun predecessors ((g1, g2, cm, tm), t) = (G.preds (G.getNode (g1, t)))

	fun moveDegree ((g1, g2, cm, tm), t) = G.inDegree (G.getNode(g2, t))

	fun checkColor ((g1, g2, cm, tm), t) = case TM.find (cm, t) of
										SOME(x) => x
									  | NONE => BLANK
	fun interDegree ((g1, g2, cm, tm), t) =
		case checkColor ((g1, g2, cm, tm), t) of
			BLANK => G.outDegree (G.getNode(g1, t))
		  | COLOR(_) => 10000000

	fun degree ((g1, g2, cm, tm), t) = G.outDegree (G.getNode(g1, t)) + G.degree (G.getNode(g2, t))

	fun moveRelated ((g1, g2, cm, tm), t) = G.degree (G.getNode(g2, t)) > 0

	val tempToString = Temp.makestring

	fun size (g1, g2, cm, tm) = TM.numItems cm

    (* take out the node *)
	fun simplify (graph, n) = SIMPLIFY(removeNode(graph, n), n)

	fun coalesce ((g1, g2, cm, tm), t1, t2) =
		let
			val newInterSuccs = NS.difference (NS.addList (NS.empty, G.succs (G.getNode (g1, t1))), NS.addList (NS.empty, G.succs (G.getNode (g1, t2))))
			val newInterPreds = NS.difference (NS.addList (NS.empty, G.preds (G.getNode (g1, t1))), NS.addList (NS.empty, G.preds (G.getNode (g1, t2))))
			val newInterEdges = (map (fn t => (t1, t)) (NS.listItems newInterSuccs))@(map (fn t => (t, t1)) (NS.listItems newInterPreds))

			val newMoveSuccs = NS.difference (NS.addList (NS.empty, G.succs (G.getNode (g2, t1))), NS.addList (NS.empty, G.succs (G.getNode (g2, t2))))
			val newMovePreds = NS.difference (NS.addList (NS.empty, G.preds (G.getNode (g2, t1))), NS.addList (NS.empty, G.preds (G.getNode (g2, t2))))
			val newMoveEdges = (map (fn t => (t1, t)) (NS.listItems newMoveSuccs))@(map (fn t => (t, t1)) (NS.listItems newMovePreds))

			val graph = removeNode ((g1, g2, cm, tm), t2)

			val graph = foldl (fn ((a, b), g) => addInter (g, a, b)) graph newInterEdges
			val (g1, g2, cm, tm) = foldl (fn ((a, b), g) => addMove (g, a, b)) graph newMoveEdges
			val tm = TM.insert (tm, t2, t1)
		in
			COALESCE((g1, g2, cm, tm), t1, t2)
		end

	fun unFreeze ((g1, g2, cm, tm), t) =
		let
			val succsList: Temp.temp G.edge list = map (fn (s) => {from=t, to=s}) (G.succs (G.getNode (g2, t)))
			val predsList: Temp.temp G.edge list = map (fn (p) => {from=p, to=t}) (G.preds (G.getNode (g2, t)))
			val moveEdges = succsList@predsList
			val g2' = (foldl (fn (e, g) => G.removeEdge (g, e)) g2 moveEdges)
		in
			UNFREEZE((g1, g2', cm, tm), t)
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

	fun interEdgesToString ((g1, _, _, _), t) = foldl (fn (t, r) => (Temp.makestring t) ^ " " ^ r) "" (G.succs (G.getNode(g1, t)))
	fun moveEdgesToString ((_, g2, _, _), t) = foldl (fn (t, r) => (Temp.makestring t) ^ " " ^ r) "" ((G.succs (G.getNode(g2, t)))@(G.preds (G.getNode(g2, t))))
	fun printColors g =
		let
			val _ = print "GRAPH: \n"
			val lst = (keyList g)
			fun colorL g (t::l) = (print ("\t" ^ (Temp.makestring t) ^ " has color " ^ (printColor (g, t) ^ "\n\t\tWith Interedges: " ^ (interEdgesToString (g, t)) ^ "\n\t\tAnd MoveEdges: " ^ (moveEdgesToString (g, t) ^ "\n"))); colorL g l)
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

	fun heuristic (g1, t1, t2) =
		let
			val n1 = G.getNode (g1, t1)
			val n2 = G.getNode (g1, t2)
			val adj = NS.listItems ((NS.addList ((NS.addList (NS.empty, (G.succs n1))), (G.succs n2))))
			val sig_deg = List.length F.usableRegs
			val degree = foldl (fn (t, i) => if G.degree (G.getNode (g1, t)) >= sig_deg then i + 1 else i) 0 adj
		in
			if not (NS.member (NS.addList (NS.empty, (G.succs n1)), t2)) andalso degree < sig_deg
			then (print "true\n"; true)
			else (print "false\n"; false)
		end


	fun nextToCoalesce (g1, g2, cm, tm) =
		let
			val nodes = G.nodes g2
			fun help (n1::l) =
				let
					val adj = NS.listItems (NS.addList ((NS.addList (NS.empty, (G.succs n1))), (G.preds n1)))
					fun help2 (t::l) = if heuristic (g1, G.getNodeID n1, t)
										then SOME(G.getNode(g2, t)) (*this line throws exception when coelesce called first*)
										else help2 l
					  | help2 [] = NONE
				in
					if List.length adj > 0 then (case help2 adj of SOME(n2) =>SOME(G.getNodeID n1, G.getNodeID n2) | NONE => NONE) else help l
				end
			  | help [] = NONE
		in
			help nodes
		end

	fun nextToUnFreeze (g1, g2, cm, tm) =
		let
			val nodes = G.nodes g2
			fun help (n::l) =
				let
					val adj = (G.succs n)@(G.preds n)
				in
					if List.length adj > 0 then SOME(G.getNodeID n) else help l
				end
			  | help [] = NONE
		in
			help nodes
		end


	fun getNodesColor (m, nID) = case TM.find (m, nID) of
									SOME(c) => c
									| NONE => BLANK
	fun getColor ((g1, g2, cm, tm), nID: K.ord_key) =
		let
			val all = S.addList(S.empty, (map (fn r => COLOR(r)) F.usableRegs))
			val remaining = foldl (fn (n, s) => S.difference (s, S.singleton(getNodesColor (cm, n)))) all (G.succs (G.getNode(g1, nID)))
			val available = foldl (fn (n, s) => S.difference (s, S.singleton(getNodesColor (cm, n)))) remaining (G.preds (G.getNode(g1, nID)))
			val available: color list = S.listItems(available)
		in
			if List.length(available) > 0
			then
				let
					val c = List.nth(available, 0)
				in
					((g1, g2, TM.insert (cm, nID, c), tm), c)
				end
			else ((g1, g2, TM.insert (cm, nID, BLANK), tm), BLANK)
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

	fun actualColorMap (cm, tm) =
		let
			fun findLast t =
				case TM.find (tm, t) of
					SOME(temp) => if temp = t then t else findLast temp
				  | NONE => (print "cant find temp in coelesce map"; t)
			fun findColor t =
				case TM.find (cm, findLast t) of
				SOME(c) => c
			  | NONE => BLANK
		in
			TM.foldli (fn (k,_ , cm') => if TM.find (cm', k) = NONE then TM.insert (cm', k, findColor k) else cm') cm tm
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

			(*
			fun trySimplify interGraph = case (print "s\n"; nextToSimplify interGraph) of
											SOME(SOME(n)) => simplify (interGraph, n)
										  | SOME(NONE) => DONE(interGraph)
										  | NONE => tryUnFreeze interGraph
			and tryCoalesce interGraph = case (print "c\n"; nextToCoalesce interGraph) of
											SOME(n1, n2) => coalesce (interGraph, n1, n2)
										  | NONE => trySimplify interGraph
			and tryUnFreeze interGraph = case (print "u\n"; nextToUnFreeze interGraph) of
											SOME(n) => unFreeze (interGraph, n)
										  | NONE => potentialSpill interGraph
			*)

            fun color interGraph =
                if size interGraph > 0
                then
                    case trySimplify interGraph of
                        SIMPLIFY(g, n)      => let
                                                  val iGraph = color g
                                                  val (graph, c) = addColoredNode (interGraph, iGraph, n)
												  val _ = print  ("Just colored node: " ^ (Temp.makestring n) ^ "\n")
                                                in
                                                    graph
                                                end
                      | COALESCE(g, n1, n2) => color g
                      | UNFREEZE(g, n)      => color g
                      | POTSPILL(g, n)      => let
                                                    val iGraph = color g
                                                    val (graph, c) = addColoredNode (interGraph, g, n)
                                                in
                                                    graph
                                                end
					  | DONE(g) => ( print "Things are already colored!\n"; g)

                else (G.empty, G.empty, TM.empty, TM.empty)

            val graph = color interGraph
        in
            case graph of
			 (_, _, cm, tm) => actualColorMap (cm, tm)
        end


    fun colorToString (COLOR(t)) = "COLOR:\t" ^ (Temp.makestring (t))
	  | colorToString (BLANK) = "BLANK"

	fun getColor ((g1, g2, cm, tm), t) =
		case TM.find (cm, t) of
			SOME(COLOR(i)) => COLOR(i)
		  | SOME(BLANK) => BLANK
		  | NONE => (print "Error: finding color of nonexistant node."; BLANK)

	fun tempToReg tempToColorMap t = case TM.find (tempToColorMap, t) of
										SOME(c) => ( case c of
														COLOR(r) => (print ("Turning REGISTER: " ^ (Temp.makestring t) ^ " into " ^ (Temp.makestring t) ^ "\n"); r)
													  | BLANK    => (print ("temp: " ^ (Temp.makestring t) ^ " is blank?\n"); F.FP))
									  | NONE => (print ("temp: " ^ (Temp.makestring t) ^ " not found in temp->color map\n"); F.FP)
end

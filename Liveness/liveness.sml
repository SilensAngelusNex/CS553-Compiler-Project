structure Live :> LIVE =
struct

    structure A = Assem
    (* structure FL = Flow *)
    structure F = FuncGraph(struct type ord_key = int val compare = Int.compare end)
    structure M = SplayMapFn(struct type ord_key = string val compare = String.compare end)
	structure S = SplaySetFn(struct type ord_key = Temp.temp val compare = Temp.compare end)
	(*	structure I = InterferenceGraph	*)

    type node = (S.set * S.set * S.set * S.set * bool)
	type nodeID = F.nodeID
				(* Defs, Uses, Out, In *)
    type graph = node F.graph

    fun updateGraph instrs (i, g, m) = if i < List.length instrs
                                     then
                                         case List.nth (instrs, i) of
                                            A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp} => updateGraph instrs (i+1, F.addNode(g, i, (S.addList (S.empty, dstLst), S.addList (S.empty, srcLst), S.empty, S.empty, false)), m)
                                          | A.LABEL{assem=a, lab=label} => updateGraph instrs (i+1, F.addNode(g, i, (S.empty, S.empty, S.empty, S.empty, false)), M.insert (m, label, i))
                                          | A.MOVE{assem=a, dst=dst, src=src} => updateGraph instrs (i+1, F.addNode(g, i, (S.singleton dst, S.singleton src, S.empty, S.empty, true)), m)
                                     else
                                        (g, m)

    fun addNextEdge instrs (i, g) = if i+1 < List.length instrs
                                    then F.addEdge(g, {from=i, to=i+1})
                                    else g

    fun addLabelEdge i m (lab, g) = case M.find (m, lab) of
                                SOME(j) => F.addEdge(g, {from=i, to=j})
                              | NONE => (print ("Why do you do this to me... " ^ (Symbol.name lab) ^ "\n"); g)

    fun addEdges instrs (i, (g, m)) = if i < List.length instrs
                                     then
                                         case List.nth (instrs, i) of
                                            A.OPER{assem=a, dst=dstLst, src=srcLst, jump=SOME(l)} => addEdges instrs (i+1, (foldl (addLabelEdge i m) g l, m))
                                          | A.OPER{assem=a, dst=dstLst, src=srcLst, jump=NONE}    => addEdges instrs (i+1, (addNextEdge instrs (i, g), m))
                                          | A.LABEL{assem=a, lab=label}                           => addEdges instrs (i+1, (addNextEdge instrs (i, g), m))
                                          | A.MOVE{assem=a, dst=dst, src=src}                     => addEdges instrs (i+1, (addNextEdge instrs (i, g), m))
                                     else
                                        g

    fun instr2graph instrs: graph =
            let
                val g = addEdges instrs (0, (updateGraph instrs (0, F.empty, M.empty)))
                val _ = F.printGraph (fn (n, (a,b,c, d, e)) => Int.toString n) g
            in
                g
            end

	fun unionIns l = foldl (fn (n, r) => case F.nodeInfo n of (def, use, ins, outs, move) => S.union (ins, r)) S.empty l

	fun livenessHelper (graph, id, bool) =
		let
			val this = F.getNode (graph, id)
			val (def, use, ins, outs, move) = F.nodeInfo this
			val ins' = S.union (use, (S.difference (outs, def)))
			val out' = unionIns (F.succs' graph this)
			val graph' = F.changeNodeData (graph, id, (def, use, ins', out', move))
			val bool' = bool andalso (S.equal (ins, ins') andalso S.equal (outs, out'))
		in
			if id <= 0
			then (graph', bool')
			else livenessHelper (graph', id - 1, bool')
		end

    fun dataAnalysis graph = case livenessHelper (graph, (F.size graph) - 1, true) of
								(g, true)  => g
							  | (g, false) => dataAnalysis (g)

	(*
	fun getTempSet graph =
		let
			fun help graph i =
				let
					val

	fun getTempList graph = S.listItems (getTempSet graph)

	fun insertInterNodes graph i = foldl (fn ((t, i), g) => F.addNode (g, i, t)) F.empty (getTempList graph)

	fun makeInterference graph = insertInterEdges graph (insertInterNodes graph (F.size graph)) (F.size graph)

	*)

    fun show (outstream, graph) =
		let
			fun printNode id =
				let
					val this = F.getNode (graph, id)
					val (def, use, ins, outs, move) = F.nodeInfo this
				in
					TextIO.output(outstream, "Node:\t" ^ (Int.toString id) ^ "\n\tIns:\t");
					S.app (fn (i) => TextIO.output(outstream, (Temp.makestring i) ^ " ")) ins;
					TextIO.output(outstream, "\n\tOuts:\t");
					S.app (fn (i) => TextIO.output(outstream, (Temp.makestring i) ^ " ")) outs;
					TextIO.output(outstream, "\n")
				end
			val ids = List.tabulate((F.size graph), (fn i => i))
		in
			app printNode ids;
			TextIO.flushOut (outstream)
		end

	fun liveness (outstream, instrs) =
	 	let
			val graph = instr2graph instrs
			val graph' = dataAnalysis graph
		in
			show (outstream, graph');
			graph'
		end

end

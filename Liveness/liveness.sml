structure Live :> LIVE =
struct

    structure A = Assem
    structure I = InterferenceGraph

    structure F = FuncGraph(struct type ord_key = int val compare = Int.compare end)
    structure M = SplayMapFn(struct type ord_key = string val compare = String.compare end)
	structure S = SplaySetFn(struct type ord_key = Temp.temp val compare = Temp.compare end)
    structure LS = SplaySetFn(struct type ord_key = string val compare = String.compare end)

    type node = (string * S.set * S.set * S.set * S.set * bool)
	type nodeID = F.nodeID
				(* Defs, Uses, Out, In *)
    type graph = node F.graph
	type intfGraph = InterferenceGraph.graph

    val emptyGraph = I.registersOnly (* foldl (fn (t, g) => I.addUnusableTemp (g, t)) I.empty I.F.unusableRegs *)

    val labelSet = foldl (fn (l, s) => LS.add (s, l)) LS.empty ["tig_initArray", "tig_stringEqual", "tig_allocRecord", "tig_exit"]

    fun updateGraph instrs (i, g, m) = if i < List.length instrs
                                     then
                                         case List.nth (instrs, i) of
                                            A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp} => updateGraph instrs (i+1, F.addNode(g, i, (a, S.addList (S.empty, dstLst), S.addList (S.empty, srcLst), S.empty, S.empty, false)), m)
                                          | A.LABEL{assem=a, lab=label} => updateGraph instrs (i+1, F.addNode(g, i, (a, S.empty, S.empty, S.empty, S.empty, false)), M.insert (m, label, i))
                                          | A.MOVE{assem=a, dst=dst, src=src} => updateGraph instrs (i+1, F.addNode(g, i, (a, S.singleton dst, S.singleton src, S.empty, S.empty, true)), m)
                                     else
                                        (g, m)

    fun addNextEdge instrs (i, g) = if i+1 < List.length instrs
                                    then F.addEdge(g, {from=i, to=i+1})
                                    else g

    fun addLabelEdge i m (lab, g) = case M.find (m, lab) of
                                SOME(j) => F.addEdge(g, {from=i, to=j})
                              | NONE => case LS.member(labelSet, lab) of
                                        true => g
                                      | false => (ErrorMsg.error 0 ("Jumping to undefined label : " ^ (Symbol.name lab) ^ "\n"); g)

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
                (*val _ = F.printGraph (fn (n, (a,b,c, d, e)) => Int.toString n) g*)
            in
                g
            end

	fun unionIns l = foldl (fn (n, r) => case F.nodeInfo n of (a, def, use, ins, outs, move) => S.union (ins, r)) S.empty l

	fun livenessHelper (graph, id, bool) =
		let
			val this = F.getNode (graph, id)
			val (a, def, use, ins, outs, move) = F.nodeInfo this
			val ins' = S.union (use, (S.difference (outs, def)))
			val out' = unionIns (F.succs' graph this)
			val graph' = F.changeNodeData (graph, id, (a, def, use, ins', out', move))
			val bool' = bool andalso (S.equal (ins, ins') andalso S.equal (outs, out'))
		in
			if id <= 0
			then (graph', bool')
			else livenessHelper (graph', id - 1, bool')
		end

    fun dataAnalysis graph = case livenessHelper (graph, (F.size graph) - 1, true) of
								(g, true)  => g
							  | (g, false) => dataAnalysis (g)


	fun getTempList graph =
		let
			fun oneLine (a, def, use, out, ins, bool) = S.union(def, S.union(use, S.union(ins, out)))
			fun help graph i =
					if i <= 0
					then S.empty
					else S.union(oneLine (F.nodeInfo (F.getNode (graph, i))), (help graph (i -1)))
			val tempSet = help graph ((F.size graph) - 1)
		in
		S.listItems (tempSet)
		end

	fun getEdgeList graph =
		let
            fun createList (d, l, bool) = foldl (fn (i, acc) => if d = i then acc else (d, i, bool)::acc) [] l
			fun oneLine (a, def, use, out, ins, false) =
				let
                    val def = S.listItems def
                    val out = S.listItems ins
                    val defCOut = foldl (fn (d, acc) => acc@createList(d, out, false)) [] def
                 in
                    defCOut
                 end
			  | oneLine (a, def, use, out, ins, true) =
  				let
                    val out = S.listItems (S.difference (ins, use))
					val def = S.listItems def
					val use = S.listItems use
                    val defCOut = foldl (fn (d, acc) => acc@createList(d, out, false)) [] def
					val moves   = foldl (fn (d, acc) => acc@createList(d, use, true)) [] def
                in
                	moves@defCOut
                end

			fun help graph i =
				if i <= 0
				then []
				else (oneLine (F.nodeInfo (F.getNode (graph, i))))@(help graph (i - 1))

			fun printR ((t1, t2, false)::l) = printR l
			  | printR ((t1, t2, true)::l) = printR l
			  | printR [] = ()
			val result = help graph ((F.size graph) - 1)
		in
		(*	printR result;	*)
		result
		end

	fun insertInterNodes graph = foldl (fn (t, g) => I.addTemp (g, t)) emptyGraph (getTempList graph)

	fun insertInterEdges graph intergraph = foldl (fn ((e1, e2, b), g) => I.addEdge (g, e1, e2, b)) intergraph (getEdgeList graph)

	fun makeInterference graph = insertInterEdges graph (insertInterNodes graph)


    fun show (outstream, graph) =
		let
			fun printNode id =
				let
					val this = F.getNode (graph, id)
					val (a, def, use, ins, outs, move) = F.nodeInfo this
				in
					TextIO.output(outstream, (if move then "Move " else "Oper ") ^ "Node:\t" ^ (Int.toString id) ^ "\t" ^ a ^ "\n\tIns:\t");
					S.app (fn (i) => TextIO.output(outstream, (Temp.makestring i) ^ " ")) ins;
					TextIO.output(outstream, "\n\tOuts:\t");
					S.app (fn (i) => TextIO.output(outstream, (Temp.makestring i) ^ " ")) outs;
					TextIO.output(outstream, "\n")
				end
			val ids = List.tabulate(((F.size graph) - 1), (fn i => i))
		in
			app printNode ids;
			TextIO.flushOut (outstream)
		end

	fun liveness (outstream, instrs) =
	 	let
			val graph = instr2graph instrs
			val graph' = dataAnalysis graph
		in
			graph'
		end

end

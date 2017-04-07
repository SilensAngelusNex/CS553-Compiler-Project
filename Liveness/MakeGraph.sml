structure MakeGraph :> MAKE =
struct

    structure A = Assem
    (* structure FL = Flow *)
    structure F = FuncGraph(struct type ord_key = int val compare = Int.compare end)
    structure M = SplayMapFn(struct type ord_key = string val compare = String.compare end)

    type node = (Temp.temp list * Temp.temp list * bool)
    type graph = node F.graph

    fun updateGraph instrs (i, g, m) = if i < List.length instrs
                                     then
                                         case List.nth (instrs, i) of
                                            A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp} => updateGraph instrs (i+1, F.addNode(g, i, (dstLst, srcLst, false)), m)
                                          | A.LABEL{assem=a, lab=label} => updateGraph instrs (i+1, F.addNode(g, i, ([], [], false)), M.insert (m, label, i))
                                          | A.MOVE{assem=a, dst=dst, src=src} => updateGraph instrs (i+1, F.addNode(g, i, ([dst], [src], true)), m)
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
                val _ = F.printGraph (fn (n, (a,b,c)) => Int.toString n) g
            in
                g
            end
end

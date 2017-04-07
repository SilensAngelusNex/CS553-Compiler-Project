signature LIVE =
sig
    datatype igraph =
                IGRAPH of {
                            graph: IGRAPH.graph,
                            tnode: Temp.temp -> IGRAPH.node,
                            gtemp: IGRAPH.node -> Temp.temp,
                            moves: (IGRAPH.node * IGRAPH.node) list
                            }
    val interferenceGraph : Flow.flowgraph -> igraph * (Flow.Graph.node -> Temp.temp list)

    val show : outstream * igraph -> unit
end

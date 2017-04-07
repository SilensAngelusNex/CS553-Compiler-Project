structure Liveness :> LIVE =
struct
    datatype igraph =
                IGRAPH of {
                            graph: IGRAPH.graph,
                            tnode: Temp.temp -> IGRAPH.node,
                            gtemp: IGRAPH.node -> Temp.temp,
                            moves: (IGRAPH.node * IGRAPH.node) list
                            }
    fun interferenceGraph (graph: Flow.flowgraph): igraph * (Flow.Graph.node -> Temp.temp list) = ()

    fun show (outstream, igraph) = ()
end

signature MAKE =
sig
    val instr2graph: Assem.instr list -> Flow.flowgraph * Flow.Graph.node list
end

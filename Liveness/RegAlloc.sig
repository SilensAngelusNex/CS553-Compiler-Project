signature ALLOC =
sig
    val regAlloc : Assem.instr list * InterferenceGraph.graph -> Assem.instr list
end

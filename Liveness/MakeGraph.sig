signature MAKE =
sig
    type graph
    val instr2graph: Assem.instr list -> graph
end

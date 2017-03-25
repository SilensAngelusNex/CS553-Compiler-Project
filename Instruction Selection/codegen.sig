signature CODEGEN =
sig
    structure Frame : Frame
    val codegen : Frame.frame -> Tree.stm -> Assem.instr list
end

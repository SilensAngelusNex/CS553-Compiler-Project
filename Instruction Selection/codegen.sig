signature CODEGEN =
sig
    structure Frame : FRAME

    val codegen : MIPSFrame.frame -> Tree.stm -> Assem.instr list
end

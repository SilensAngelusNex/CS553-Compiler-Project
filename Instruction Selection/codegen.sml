structure Mipsgen :> CODEGEN =
struct

    structure Frame = MIPSFrame
    structure A = Assem
    structure T = Tree

    fun codegen (Fframe) (stm: Tree.stm) : Assem.instr list =
        let
            val ilist = ref (nil: A.instr list)

            fun emit x = ilist := x :: !ilist

            fun result (gen) = let
                                    val t = Temp.newtemp()
                                in
                                gen t;
                                t
                                end

            fun munchStm(T.SEQ(a,b)) = (munchStm a; munchStm)
              | munchStm(T.SEQ(a,b)) = (munchStm a; munchStmb)

            and munchExp(T.Temp t) = t
              | munchExp(T.BINOP(T.PLUS, e1, e2)) =
                    result (
                            fn r => emit(A.OPER {
                                                 assem="ADD 'd0 <- 's0 + 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r]
                                                 })
                        )

            and munchArgs
        in
            munchStm stm;
            rev(!ilist)
        end
end

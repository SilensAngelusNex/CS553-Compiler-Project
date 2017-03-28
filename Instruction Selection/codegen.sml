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
              | munchStm(T.LABEL lab) = emit (A.LABEL{assem=lab ^ ":\n", lab=lab})
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, e1, T.CONST(i))), e2)) =
                emit(A.OPER{
                        assem="sw 's1, " ^ Int.toString i ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, T.CONST(i), e1)), e2)) =
                emit(A.OPER{
                        assem="sw 's1, " ^ Int.toString i ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.MINUS, e1, T.CONST(i))), e2)) =
                emit(A.OPER{
                        assem="sw 's1, " ^ Int.toString (0 - i) ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.MINUS, T.CONST(i), e1)), e2)) =
                emit(A.OPER{
                        assem="sw 's1, " ^ Int.toString (0 - i) ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(CONST i), e2) =
                emit(A.OPER{
                        assem="sw 's0, " ^ Int.toString i ^ "('r0)\n" ,
                        src=[munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(e1), e2) =
                emit(A.OPER{
                        assem="sw 's1, 0('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, e2)) =
                emit(A.OPER{
                        assem="add 'd0, 's0', r0\n" ,
                        src=[munchExp e2],
                        dst=[i],
                        jump=NONE
                    })

            and munchExp(T.Temp t) = t
              | munchExp(T.CONST(i)) =
                  result (fn r => emit(A.OPER {
                                                assem="addi 'd0, r0, " ^ Int.toString i ^"\n",
                                                src=[],
                                                dst=[r],
                                                jump=NONE
                                            }
              | munchExp(T.BINOP(T.PLUS, e1, T.CONST (i))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="addi 'd0, 's0, " ^ Int.toString i ^ "\n",
                                               src=[munchExp e1],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.PLUS, T.CONST(i), e1)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="addi 'd0, 's0, " ^ Int.toString i ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.PLUS, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="add 'd0 <- 's0 + 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MINUS, e1, T.CONST (i))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="addi 'd0, 's0, " ^ Int.toString (0 - i) ^ "\n",
                                               src=[munchExp e1],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.MINUS, T.CONST(i), e1)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="addi 'd0, 's0, " ^ Int.toString (0 - i) ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MINUS, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="sub 'd0 <- 's0 + 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              |

            and munchArgs
        in
            munchStm stm;
            rev(!ilist)
        end
end

structure MIPSGen :> CODEGEN =
struct

    structure Frame = MIPSFrame
    structure A = Assem
    structure T = Tree

    fun codegen (Fframe: Frame.frame) (stm: Tree.stm) : Assem.instr list =
        let
            val ilist = ref (nil: A.instr list)

            fun emit x = ilist := x :: !ilist

            fun result (gen) = let
                                    val t = Temp.newtemp()
                                in
                                gen t;
                                t
                                end

            fun postCall () = ""
            fun preCall () = ""

            fun munchStm(T.SEQ(a,b)): unit = (munchStm a; munchStm b)
              | munchStm(T.EXP(m1)) = (munchExp m1; ())
              | munchStm(T.LABEL lab) = emit (A.LABEL{assem=lab ^ ":\n", lab=lab})
              | munchStm(T.MOVE(T.TEMP i, T.TEMP j)) =
                emit(A.MOVE{
                        assem="\tmove\t'd0, 's0\n" ,
                        src=j,
                        dst=i
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, e1, T.CONST(i))), e2)) =
                emit(A.OPER{
                        assem="\tsw\t's1, " ^ Int.toString i ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, T.CONST(i), e1)), e2)) =
                emit(A.OPER{
                        assem="\tsw\t's1, " ^ Int.toString i ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.MINUS, e1, T.CONST(i))), e2)) =
                emit(A.OPER{
                        assem="\tsw\t's1, " ^ Int.toString (0 - i) ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.MINUS, T.CONST(i), e1)), e2)) =
                emit(A.OPER{
                        assem="\tsw\t's1, " ^ Int.toString (0 - i) ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.CONST i), e2)) =
                emit(A.OPER{
                        assem="\tsw\t's0, " ^ Int.toString i ^ "('s1)\n" ,
                        src=[munchExp e2, Frame.R0],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(e1), e2)) =
                emit(A.OPER{
                        assem="\tsw\t's1, 0('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.NAME(l))) =
                emit(A.OPER{
                        assem="\tadd\t'd0, 's0, 's1\n" ,
                        src=[Frame.R0, Frame.R0],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, e2)) =
                emit(A.OPER{
                        assem="\tadd\t 'd0, 's0, 's1\n" ,
                        src=[munchExp e2, Frame.R0],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(e1, e2)) =
                emit(A.OPER{
                       assem="\n" ,
                       src=[munchExp e1, munchExp e1],
                       dst=[],
                       jump=NONE
                    })
              | munchStm(T.JUMP(T.NAME l, [a])) =
                emit(A.OPER{
                        assem="\tj\t " ^ l ^ "\n\n" ,
                        src=[],
                        dst=[],
                        jump=SOME([a])
                    })
              | munchStm(T.JUMP(e1, tLst)) = (* dasfbshdajbfkjhsdbfkjhasdbkj *)
                emit(A.OPER{
                        assem="\tj\t 's0\n\n",
                        src=[munchExp e1, Frame.R0],
                        dst=[],
                        jump=SOME(tLst)
                    })
              | munchStm(T.CJUMP(T.EQ, e1, e2, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t 's0, 's1, " ^ l1 ^ "\nj " ^ l2 ^ "\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.NE, e1, e2, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t 's0, 's1, " ^ l2 ^ "\nj " ^ l1 ^ "\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.GT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t 'd0, 's1, 's0\nbeqz 's2, " ^ l2 ^ "\nj " ^ l1 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t 'd0, 's0, 's1\nbeqz 's2, " ^ l2 ^ "\nj " ^ l1 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t 'd0, 's1, 's0\nbeqz 's2, " ^ l1 ^ "\nj " ^ l2 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.GE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t 'd0, 's0, 's1\nbeqz 's2, " ^ l1 ^ "\nj " ^ l2 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t 'd0, 's1, 's0\nbeqz 's2, " ^ l2 ^ "\nj " ^ l1 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t 'd0, 's0, 's1\nbeqz 's2, " ^ l2 ^ "\nj " ^ l1 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t 'd0, 's1, 's0\nbeqz 's2, " ^ l1 ^ "\nj " ^ l2 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\nbeqz 's2, " ^ l1 ^ "\nj " ^ l2 ^ "\n" ,
                            src=[munchExp e1, munchExp e2, cond],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end


            and munchExp(T.TEMP t): Assem.temp = t
              | munchExp(T.NAME l) = result (fn r => emit(A.LABEL { assem=l ^ "\n", lab=l }))
              | munchExp(T.CONST(i)) =
                  result (fn r => emit(A.OPER {
                                                assem="\taddi\t'd0, 's0, " ^ Int.toString i ^"\n",
                                                src=[Frame.R0],
                                                dst=[r],
                                                jump=NONE
                                            }))
              | munchExp(T.BINOP(T.PLUS, e1, T.CONST (i))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="\taddi\t'd0, 's0, " ^ Int.toString i ^ "\n",
                                               src=[munchExp e1],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.PLUS, T.CONST(i), e1)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t 'd0, 's0, " ^ Int.toString i ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.PLUS, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tadd\t 'd0 <- 's0 + 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MINUS, e1, T.CONST (i))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="\taddi\t 'd0, 's0, " ^ Int.toString (0 - i) ^ "\n",
                                               src=[munchExp e1],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.MINUS, T.CONST(i), e1)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t 'd0, 's0, " ^ Int.toString (0 - i) ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MINUS, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsub\t 'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.DIV, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tdiv\t 's0, 's1\n mflo 'd0",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MUL, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tmul\t 's0, 's1\n mflo 'd0",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.AND, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tand\t 'd0, 's0, 's1",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.OR, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tor\t 'd0, 's0, 's1",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.XOR, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\txor\t 'd0, 's0, 's1",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.LSHIFT, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsllv\t 'd0, 's0, 's1",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.RSHIFT, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsrlv\t 'd0, 's0, 's1",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.ARSHIFT, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsra\t 'd0, 's0, 's1",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(T.BINOP(T.PLUS, e1, T.CONST i))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t 'd0, " ^ Int.toString i ^ "('s0)\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(T.BINOP(T.PLUS, T.CONST i, e1))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t 'd0, " ^ Int.toString i ^ "('s0)\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(T.CONST i)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t 'd0, " ^ Int.toString i ^ "('s0)\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(e1)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t 'd0, 0('s0)\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.ESEQ(stm1, e1)) = (munchStm stm1; munchExp e1)
              | munchExp(T.CALL(e, args)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem=(preCall () ^ "\tjal 's0\n\n" ^ postCall ()),
                                                 src=munchExp(e)::munchArgs(0, args),
                                                 dst=[Frame.V0, Frame.V1],
                                                 jump=NONE
                                                 }))


            and munchArgs(0, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A0, arg)); Frame.A0)::munchArgs (1, args)
              | munchArgs(1, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A1, arg)); Frame.A1)::munchArgs (2, args)
              | munchArgs(2, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A2, arg)); Frame.A2)::munchArgs (3, args)
              | munchArgs(3, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A3, arg)); Frame.A3)::munchArgs (4, args)
              | munchArgs(i, arg::args) = (munchStm(T.SEQ(
				  											T.MOVE(T.TEMP Frame.SP, T.BINOP(T.PLUS, Frame.SP, T.CONST(4))),
				  											T.MOVE(T.MEM(T.TEMP Frame.SP), arg)));
										  munchArgs (i + 1, args))
              | munchArgs(i, []) = []
        in
            munchStm stm;
            rev(!ilist)
        end
end

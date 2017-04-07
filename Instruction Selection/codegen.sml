structure MIPSGen :> CODEGEN =
struct

    structure Frame = MIPSFrame
    structure A = Assem
    structure T = Tree

    fun intToString (i) = if i < 0
                          then "-" ^ Int.toString (~i)
                          else Int.toString (i)

   fun intInfToString (i) = intToString (IntInf.toInt i)
   fun wordToString   (i) = intToString (Word.toInt i)


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
                        assem="\tmov\t'd0, 's0\n",
                        src=j,
                        dst=i
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, e1, T.CONST(i))), e2)) =
                emit(A.OPER{
                        assem="\tsw\t\t's1, " ^ (intToString i) ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, T.CONST(i), e1)), e2)) =
                emit(A.OPER{
                        assem="\tsw\t\t's1, " ^ Int.toString i ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.MINUS, e1, T.CONST(i))), e2)) =
                emit(A.OPER{
                        assem="\tsw\t\t's1, " ^ (intToString (~i)) ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(T.BINOP(T.MINUS, T.CONST(i), e1)), e2)) =
                emit(A.OPER{
                        assem="\tsw\t\t's1, " ^ (intToString (~i)) ^ "('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.MEM(e1), T.MEM(e2))) =
                let
                    val t = Temp.newtemp ()
                in
                emit(A.OPER{
                        assem="\tlw\t\t'd0, 0('s0)\n\tsw\t\t'd1, 0('s1)\n" ,
                        src=[munchExp e2, munchExp e1],
                        dst=[t],
                        jump=NONE
                    })
                end
              | munchStm(T.MOVE(T.MEM(T.CONST i), e2)) =
                emit(A.OPER{
                        assem="\tsw\t\t's0, " ^ (intToString i) ^ "('s1)\n" ,
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
                        assem="\tla\t\t'd0, " ^ l ^ "\n" ,
                        src=[],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, e2)) =
                emit(A.OPER{
                        assem="\tadd\t\t'd0, 's0, 's1\n" ,
                        src=[munchExp e2, Frame.R0],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(e1, e2)) = ErrorMsg.error ~1 ("Trying to move into non-location")
              | munchStm(T.JUMP(T.NAME l, a)) =
                emit(A.OPER{
                        assem="\tj\t\t" ^ l ^ "\n\n" ,
                        src=[],
                        dst=[],
                        jump=SOME(a)
                    })
              | munchStm(T.JUMP(e1, tLst)) =
                emit(A.OPER{
                        assem="\tjr\t\t's0\n\n",
                        src=[munchExp e1],
                        dst=[],
                        jump=SOME(tLst)
                    })
              | munchStm(T.CJUMP(T.EQ, T.CONST i, T.CONST j, l1, l2)) = if i = j
                  then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                  else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.EQ, T.CONST 0, e2, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                        src=[Frame.R0, munchExp e2],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.EQ, e1, T.CONST 0, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                        src=[munchExp e1, Frame.R0],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.EQ, e1, e2, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.NE, T.CONST i, T.CONST j, l1, l2)) = if i <> j
                  then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                  else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.NE, T.CONST 0, e2, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                        src=[Frame.R0, munchExp e2],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.NE, e1, T.CONST 0, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l2 ^ "\n\tj\t\t " ^ l1 ^ "\n" ,
                        src=[munchExp e1, Frame.R0],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.NE, e1, e2, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.GT, T.CONST i, T.CONST j, l1, l2)) = if i > j
                  then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                  else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.GT, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.GT, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.GT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n\tbeqz\t'do, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LT, T.CONST i, T.CONST j, l1, l2)) = if i < j
                    then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                    else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.LT, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LT, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LE, T.CONST i, T.CONST j, l1, l2)) = if i <= j
                    then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                    else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.LE, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LE, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.GE, T.CONST i, T.CONST j, l1, l2)) = if i >= j
                    then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                    else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.GE, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
            | munchStm(T.CJUMP(T.GE, e1, T.CONST 0, l1, l2)) =
                let
                  val cond = Temp.newtemp()
                in
                  emit(A.OPER{
                          assem="\tslt\t\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                          src=[munchExp e1, Frame.R0],
                          dst=[cond],
                          jump=SOME([l1, l2])
                      })
                end
              | munchStm(T.CJUMP(T.GE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGT, T.CONST i, T.CONST j, l1, l2)) = if (Word.fromInt i) > (Word.fromInt j)
                    then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                    else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.UGT, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGT, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULT, T.CONST i, T.CONST j, l1, l2)) = if (Word.fromInt i) < (Word.fromInt j)
                    then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                    else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.ULT, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t\t'do, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n",
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULT, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULE, T.CONST i, T.CONST j, l1, l2)) = if (Word.fromInt i) <= (Word.fromInt j)
                    then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                    else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.ULE, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULE, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's1, 's0\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGE, T.CONST i, T.CONST j, l1, l2)) = if (Word.fromInt i) >= (Word.fromInt j)
                    then emit(A.OPER{ assem="\tj\t\t" ^ l1 ^ "\n" , src=[], dst=[], jump=SOME([l1]) })
                    else emit(A.OPER{ assem="\tj\t\t" ^ l2 ^ "\n" , src=[], dst=[], jump=SOME([l2]) })
              | munchStm(T.CJUMP(T.UGE, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGE, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                   end
              | munchStm(T.CJUMP(T.UGE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n\tbeqz\t'd0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=SOME([l1, l2])
                        })
                  end


            and munchExp(T.TEMP t): Assem.temp = t
              | munchExp(T.NAME l) = (ErrorMsg.error ~1 ("Unexpected Instance of T.NAME") ; result (fn r => ()))
              | munchExp(T.CONST(i)) =
                  result (fn r => emit(A.OPER {
                                                assem="\taddi\t'd0, 's0, " ^ (intToString i) ^"\n",
                                                src=[Frame.R0],
                                                dst=[r],
                                                jump=NONE
                                            }))
              | munchExp(T.BINOP(T.PLUS, T.CONST (i), T.CONST (j))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="\taddi\t'd0, 's0, " ^ (intToString (i + j)) ^ "\n",
                                               src=[Frame.R0],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.PLUS, e1, T.CONST (i))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="\taddi\t'd0, 's0, " ^ (intToString i) ^ "\n",
                                               src=[munchExp e1],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.PLUS, T.CONST(i), e1)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (intToString i) ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.PLUS, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tadd\t\t'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MINUS, T.CONST (i), T.CONST (j))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="\taddi\t'd0, 's0, " ^ (intToString (i - j)) ^ "\n",
                                               src=[Frame.R0],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.MINUS, e1, T.CONST (i))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="\taddi\t'd0, 's0, " ^ (intToString (~i)) ^ "\n",
                                               src=[munchExp e1],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.MINUS, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsub\t\t'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.DIV, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t 'd0, 's0, " ^ (intToString (i div j)) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.DIV, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tdiv\t\t's0, 's1\n\tmflo\t'd0\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MUL, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (intToString (i * j)) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MUL, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tmul\t\t's0, 's1\n\tmflo\t'd0\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.AND, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (intInfToString (IntInf.andb (IntInf.fromInt i, IntInf.fromInt j))) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.AND, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tand\t\t'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.OR, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (intInfToString (IntInf.orb (IntInf.fromInt i, IntInf.fromInt j))) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.OR, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tor\t\t'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.XOR, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (intInfToString (IntInf.xorb (IntInf.fromInt i, IntInf.fromInt j))) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.XOR, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\txor\t\t'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.LSHIFT, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (intInfToString (IntInf.<< (IntInf.fromInt i, (Word.fromInt j)))) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.LSHIFT, e1, T.CONST(i))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsll\t\t'd0, 's0, " ^ (intToString i) ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.LSHIFT, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsllv\t'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.RSHIFT, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (wordToString (Word.>> (Word.fromInt i, (Word.fromInt j)))) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.RSHIFT, e1, T.CONST(i))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsrl\t\t'd0, 's0, " ^ (intToString i) ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.RSHIFT, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsrlv\t'd0, 's0, 's1",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.ARSHIFT, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\taddi\t'd0, 's0, " ^ (intInfToString (IntInf.~>> (IntInf.fromInt i, (Word.fromInt j)))) ^ "\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.ARSHIFT, e1, T.CONST(i))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsra\t\t'd0, 's0, " ^ (intToString i) ^ "\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.ARSHIFT, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tsrav\t\t'd0, 's0, 's1\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(T.BINOP(T.PLUS, e1, T.CONST i))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t\t'd0, " ^ (intToString i) ^ "('s0)\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(T.BINOP(T.PLUS, T.CONST i, e1))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t\t'd0, " ^ (intToString i)  ^ "('s0)\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(T.BINOP(T.MINUS, e1, T.CONST i))) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t\t'd0, " ^ (intToString (~i)) ^ "('s0)\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(T.CONST i)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t\t'd0, " ^ (intToString i) ^ "('s0)\n",
                                                 src=[Frame.R0],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.MEM(e1)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tlw\t\t'd0, 0('s0)\n",
                                                 src=[munchExp e1],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.ESEQ(stm1, e1)) = (munchStm stm1; munchExp e1)
              | munchExp(T.CALL(T.NAME(l), args)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem=(preCall () ^ "\tjal\t\t'j0\n\n" ^ postCall ()),
                                                 src=munchArgs(0, args),
                                                 dst=[Frame.V0, Frame.V1],
                                                 jump=SOME([l])
                                                 }))


            and munchArgs(0, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A0, arg)); Frame.A0)::munchArgs (1, args)
              | munchArgs(1, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A1, arg)); Frame.A1)::munchArgs (2, args)
              | munchArgs(2, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A2, arg)); Frame.A2)::munchArgs (3, args)
              | munchArgs(3, arg::args) = (munchStm(T.MOVE(T.TEMP Frame.A3, arg)); Frame.A3)::munchArgs (4, args)
              | munchArgs(i, arg::args) = (munchStm(T.SEQ(
				  											T.MOVE(T.TEMP Frame.SP, T.BINOP(T.PLUS, T.TEMP Frame.SP, T.CONST(4))),
				  											T.MOVE(T.MEM(T.TEMP Frame.SP), arg)));
										  munchArgs (i + 1, args))
              | munchArgs(i, []) = []
        in
            munchStm stm;
            rev(!ilist)
        end
end

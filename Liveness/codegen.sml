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

			fun preCall () = () (* Emit some things? Push live callersaves onto stack. *)
            fun postCall () = () (* Emit some things? Pop live callersaves from stack. *)
			fun prologue () = () (* Emit some things? Push calleesaves onto stack if we use them. *)
            fun epilogue () = () (* Emit some things? Push calleesaves from stack if we used them. *)

            fun munchStm(T.SEQ(a,b)): unit = (munchStm a; munchStm b)
              | munchStm(T.EXP(m1)) = (munchExp m1; ())
              | munchStm(T.LABEL lab) = emit (A.LABEL{assem=lab ^ ":\n", lab=lab})
              | munchStm(T.MOVE(T.TEMP i, T.TEMP j)) =
                emit(A.MOVE{
                        assem="\tmove\t'd0, 's0\n",
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
                        assem="\tlw\t\t'd0, 0('s0)\n" ,
                        src=[munchExp e2],
                        dst=[t],
                        jump=NONE
                    });
				emit(A.OPER{
                        assem="\tsw\t\t'd1, 0('s1)\n" ,
                        src=[munchExp e1],
                        dst=[],
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
                emit(A.OPER {
                        assem="\tsw\t\t's1, 0('s0)\n" ,
                        src=[munchExp e1, munchExp e2],
                        dst=[],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.TEMP j))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, 0('s0)\n" ,
                        src=[j],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.CONST n))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, " ^ (intToString n) ^ "('s0)\n",
                        src=[Frame.R0],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.BINOP (T.PLUS, T.TEMP j, T.CONST n)))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, " ^ (intToString n) ^ "('s0)\n",
                        src=[j],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.BINOP (T.PLUS, e2, T.CONST n)))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, " ^ (intToString n) ^ "('s0)\n",
                        src=[munchExp e2],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.BINOP (T.PLUS, T.CONST n, T.TEMP j)))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, " ^ (intToString n) ^ "('s0)\n",
                        src=[j],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.BINOP (T.PLUS, T.CONST n, e2)))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, " ^ (intToString n) ^ "('s0)\n",
                        src=[munchExp e2],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.BINOP (T.MINUS, T.TEMP j, T.CONST n)))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, " ^ (intToString (~n)) ^ "('s0)\n",
                        src=[j],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(T.BINOP (T.MINUS, e2, T.CONST n)))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, " ^ (intToString (~n)) ^ "('s0)\n",
                        src=[munchExp e2],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.MEM(e2))) =
                emit(A.OPER {
                        assem="\tlw\t\t'd0, 0('s0)\n" ,
                        src=[munchExp e2],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, T.NAME(l))) =
                emit(A.OPER {
                        assem="\tla\t\t'd0, " ^ l ^ "\n" ,
                        src=[],
                        dst=[i],
                        jump=NONE
                    })
              | munchStm(T.MOVE(T.TEMP i, e2)) =
                emit(A.MOVE {
                        assem="\tmove\t'd0, 's0\n" ,
                        src=munchExp e2,
                        dst=i
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
                        src=[munchExp e1, Frame.V0, Frame.V1],
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
                        dst=[Frame.R0],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.EQ, e1, T.CONST 0, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                        src=[munchExp e1, Frame.R0],
                        dst=[Frame.R0],
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
                        dst=[Frame.R0],
                        jump=SOME([l1, l2])
                    })
              | munchStm(T.CJUMP(T.NE, e1, T.CONST 0, l1, l2)) =
                emit(A.OPER{
                        assem="\tbeq\t\t's0, 's1, " ^ l2 ^ "\n\tj\t\t " ^ l1 ^ "\n" ,
                        src=[munchExp e1, Frame.R0],
                        dst=[Frame.R0],
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
                            assem="\tslt\t\t'd0, 's1, 's0\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.GT, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0" ,
                            src=[munchExp e1, Frame.R0],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.GT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[cond],
                            dst=[],
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
                            assem="\tslt\t\t'd0, 's0, 's1\n" ,
                            src=[munchExp e1, Frame.R0],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LT, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t'd0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[],
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
                            assem="\tslt\t\t'd0, 's1, 's0\n",
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
							assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
							src=[cond],
							dst=[],
							jump=SOME([l1, l2])
						})
                  end
              | munchStm(T.CJUMP(T.LE, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n",
                            src=[munchExp e1, Frame.R0],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.LE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's1, 's0\n",
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[cond],
                            dst=[],
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
                            assem="\tslt\t\t'd0, 's0, 's1\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
            | munchStm(T.CJUMP(T.GE, e1, T.CONST 0, l1, l2)) =
                let
                  val cond = Temp.newtemp()
                in
                	emit(A.OPER{
                        	assem="\tslt\t\t'd0, 's0, 's1\n" ,
                        	src=[munchExp e1, Frame.R0],
                        	dst=[cond, Frame.R0],
                        	jump=NONE
                      });
					emit(A.OPER{
                          	assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                          	src=[cond],
                          	dst=[],
                          	jump=SOME([l1, l2])
                        })
                end
              | munchStm(T.CJUMP(T.GE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tslt\t\t'd0, 's0, 's1\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
							assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
							src=[cond],
							dst=[],
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
                            assem="\tsltu\t'd0, 's0, 's1\n",
                            src=[munchExp e1, Frame.R0],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGT, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n",
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n",
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[cond],
                            dst=[],
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
                            assem="\tsltu\t'd0, 's0, 's1\n",
                            src=[munchExp e1, Frame.R0],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n",
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULT, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULT, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t\t's0, " ^ l2 ^ "\n\tj\t\t" ^ l1 ^ "\n" ,
                            src=[cond],
                            dst=[],
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
                            assem="\tsltu\t'd0, 's1, 's0\n" ,
                            src=[munchExp e1, Frame.R0],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULE, T.CONST 0, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's1, 's0\n" ,
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.ULE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's1, 's0\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[cond],
                            dst=[],
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
                            assem="\tsltu\t'd0, 's0, 's1\n",
                            src=[Frame.R0, munchExp e2],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end
              | munchStm(T.CJUMP(T.UGE, e1, T.CONST 0, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n",
                            src=[munchExp e1, Frame.R0],
                            dst=[cond, Frame.R0],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n",
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                   end
              | munchStm(T.CJUMP(T.UGE, e1, e2, l1, l2)) =
                  let
                    val cond = Temp.newtemp()
                  in
                    emit(A.OPER{
                            assem="\tsltu\t'd0, 's0, 's1\n" ,
                            src=[munchExp e1, munchExp e2],
                            dst=[cond],
                            jump=NONE
                        });
					emit(A.OPER{
                            assem="\tbeqz\t's0, " ^ l1 ^ "\n\tj\t\t" ^ l2 ^ "\n" ,
                            src=[cond],
                            dst=[],
                            jump=SOME([l1, l2])
                        })
                  end


            and munchExp(T.TEMP t): Assem.temp = t
              | munchExp(T.NAME l) = (ErrorMsg.error ~1 ("Unexpected Instance of T.NAME") ; result (fn r => ()))
              | munchExp(T.CONST(i)) =
                  result (fn r => emit(A.OPER {
                                                assem="\tli\t\t'd0, " ^ (intToString i) ^"\n",
                                                src=[],
                                                dst=[r],
                                                jump=NONE
                                            }))
              | munchExp(T.BINOP(T.PLUS, T.CONST (i), T.CONST (j))) =
                  result (
                      fn r => emit(A.OPER {
                                               assem="\tli\t\t'd0, " ^ (intToString (i + j)) ^ "\n",
                                               src=[],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.PLUS, e1, T.CONST (0))) =
                  result (
                      fn r => emit(A.MOVE {
                                               assem="\tmove\t'd0, 's0\n",
                                               src=munchExp e1,
                                               dst=r
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
              | munchExp(T.BINOP(T.PLUS, T.CONST(0), e1)) =
                    result (
                        fn r => emit(A.MOVE {
                                                 assem="\tmove\t'd0, 's0\n",
                                                 src=munchExp e1,
                                                 dst=r
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
                                               assem="\tli\t'd0, " ^ (intToString (i - j)) ^ "\n",
                                               src=[],
                                               dst=[r],
                                               jump=NONE
                                                })
                        )
              | munchExp(T.BINOP(T.MINUS, e1, T.CONST (0))) =
                  result (
                      fn r => emit(A.MOVE {
                                               assem="\tmove\t'd0, 's0\n",
                                               src=munchExp e1,
                                               dst=r
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
                                                 assem="\tli\t\t 'd0, " ^ (intToString (i div j)) ^ "\n",
                                                 src=[],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.DIV, e1, T.CONST(1))) =
                    result (
                        fn r => emit(A.MOVE {
                                                 assem="\tmove\t'd0, 's0\n",
                                                 src=munchExp e1,
                                                 dst=r
                                                 })
                        )
              | munchExp(T.BINOP(T.DIV, e1, e2)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tdiv\t\t's0, 's1\n\tmflo\t'd0\n",
                                                 src=[munchExp e1, munchExp e2],
                                                 dst=[r, Frame.R0],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MUL, T.CONST i, T.CONST j)) =
                    result (
                        fn r => emit(A.OPER {
                                                 assem="\tli\t\t'd0, " ^ (intToString (i * j)) ^ "\n",
                                                 src=[],
                                                 dst=[r],
                                                 jump=NONE
                                                 })
                        )
              | munchExp(T.BINOP(T.MUL, e1, T.CONST(1))) =
                    result (
                        fn r => emit(A.MOVE {
                                                 assem="\tmove\t'd0, 's0\n",
                                                 src=munchExp e1,
                                                 dst=r
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
                                                 assem="\tli\t\t'd0, " ^ (intInfToString (IntInf.andb (IntInf.fromInt i, IntInf.fromInt j))) ^ "\n",
                                                 src=[],
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
                                                 assem="\tli\t\t'd0, " ^ (intInfToString (IntInf.orb (IntInf.fromInt i, IntInf.fromInt j))) ^ "\n",
                                                 src=[],
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
                                                 assem="\tli\t'd0, " ^ (intInfToString (IntInf.xorb (IntInf.fromInt i, IntInf.fromInt j))) ^ "\n",
                                                 src=[],
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
                                                 assem="\tli\t\t'd0, " ^ (intInfToString (IntInf.<< (IntInf.fromInt i, (Word.fromInt j)))) ^ "\n",
                                                 src=[],
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
                                                 assem="\tli\t\t'd0, " ^ (wordToString (Word.>> (Word.fromInt i, (Word.fromInt j)))) ^ "\n",
                                                 src=[],
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
                                                 assem="\tli\t'd0, " ^ (intInfToString (IntInf.~>> (IntInf.fromInt i, (Word.fromInt j)))) ^ "\n",
                                                 src=[],
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
                                                 dst=[r, Frame.R0],
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
                        fn r => (
								preCall ();
								emit(A.OPER {
                                        assem="\tjal\t\t'j0\n\n",
                                        src=munchArgs(0, args),
                                        dst=[Frame.V0, Frame.V1, Frame.A0, Frame.A1, Frame.A2, Frame.A3]@(Frame.getTemps Frame.callersaves),
                                        jump=SOME([l])
                                    });
								emit(A.OPER {
                                        assem="\tmove\t'd0, 's0\n",
                                        src=[Frame.V0],
                                        dst=[r],
                                        jump=NONE
                                    });
								postCall ())
							)
			  | munchExp(T.CALL(T.TEMP(t), args)) =
				  result (
					  	fn r => (
							  	preCall ();
							  	emit(A.OPER {
									  	assem="\tjalr\t\t's0\n\n",
									  	src=t::munchArgs(0, args),
									  	dst=[Frame.V0, Frame.V1, Frame.A0, Frame.A1, Frame.A2, Frame.A3]@(Frame.getTemps Frame.callersaves),
									  	jump=SOME([])
									});
								emit(A.OPER {
                                        assem="\tmove\t'd0, 's0\n",
                                        src=[Frame.V0],
                                        dst=[r],
                                        jump=NONE
                                    });
								postCall ())
							)
			  | munchExp(T.CALL(e1, args)) =
				  result (
					  	fn r => (
							  	preCall ();
							  	emit(A.OPER {
									  	assem="\tjalr\t\t's0\n\n",
									  	src=(munchExp e1)::munchArgs(0, args),
									  	dst=[Frame.V0, Frame.V1, Frame.A0, Frame.A1, Frame.A2, Frame.A3]@(Frame.getTemps Frame.callersaves),
									  	jump=SOME([])
									});
								emit(A.OPER {
                                        assem="\tmove\t'd0, 's0\n",
                                        src=[Frame.V0],
                                        dst=[r],
                                        jump=NONE
                                    });
								postCall ())
							)


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
			prologue ();
            munchStm stm;
			epilogue ();
            rev(!ilist)
        end
end

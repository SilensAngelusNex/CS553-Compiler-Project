structure Translate: TRANSLATE =
struct

	structure F = MIPSFrame
	structure T = Tree
	structure A = Absyn

	datatype exp = Ex of Tree.exp
				 | Nx of Tree.stm
				 | Cx of Temp.label * Temp.label -> Tree.stm

	datatype level = L of F.frame * level * unit ref
					| EMPTY

	type access = level * F.access

	val outermost = L(F.newFrame {name=Temp.namedlabel "tig_main", formals=[true]}, EMPTY, ref ())
	fun clearOutermost () = case outermost of L(f, _, _) => (F.clearFormals (f, [true]); ()) | EMPTY => ()

	fun getFrame (L(f, _, _)) = f
	  | getFrame EMPTY = getFrame outermost

	fun removeFirst (a::l) = l
	  | removeFirst [] = []

	val fragList: F.frag list ref = ref []

	fun getResult () = let val result = !fragList in fragList := []; clearOutermost (); result end

	fun getLevelInfo (L(frame, p, u)) = (map (fn frameAccess => (L(frame, p, u) , frameAccess)) (removeFirst (removeFirst (F.formals frame))), (F.label frame))
	  | getLevelInfo EMPTY = ([], Temp.newlabel ())

	fun newLevel {parent=parent, name=name, formals=formals} = let
																	val n = F.newFrame {name=name, formals=true::true::formals}
															   in
															   		L(n, parent, ref ())
															   end

	fun equal (L(_, _, u1), L(_, _, u2)) = u1 = u2
	  | equal (EMPTY, EMPTY) = (ErrorMsg.error 0 ("EMPTY level == EMPTY level"); true)
	  | equal (_, _) = false

    fun allocTemp level = case level of L(f, _, _) 	=> {level=level, temp=F.allocTemp f}
   						  			  | EMPTY 		=> 	allocTemp (newLevel {parent=outermost, name=Temp.newlabel (), formals=[true]})

	fun leaveLevel level = case level of
							  L(_, EMPTY, _) => outermost
							| L(_, p, _) => p
							| EMPTY => outermost;


	fun formals (L(frame, a, u)): access list = (case F.formals frame of
													c::l => (map (fn b => (L(frame, a, u), b)) l)
												   | []  => [])

	  | formals EMPTY: access list = []

	fun allocLocal (L(frame, p, u)) bool = (L(frame, p, u), F.allocLocal frame bool)
	  | allocLocal EMPTY bool = let
									val level = newLevel {parent=outermost, name=Temp.newlabel (), formals=[true]}
								in
									allocLocal level bool
								end



	fun staticLink (L(f1, p1, u1), L(f2, p2, u2), link) = (case u1 = u2 of
															true => link
															| false => staticLink (L(f1, p1, u1), p2, T.MEM(link)))
	  | staticLink (EMPTY, L(f2, p2, u2), link) = staticLink (EMPTY, p2, T.MEM(link))
	  | staticLink (L(f1, p1, u1), EMPTY, link) = (ErrorMsg.error 0 ("Static link not found."); link)
	  | staticLink (EMPTY, EMPTY, link) = link

	fun callStaticLink (L(f1, p1, u1), L(f2, p2, u2), fp) =
		if equal (p2, L(f1, p1, u1))
		then fp
		else if equal (p1, p2)
			then T.MEM(fp)
			else callStaticLink (p1, L(f2, p2, u2), T.MEM(fp))
	  | callStaticLink (EMPTY, b, fp) = callStaticLink (outermost, b, fp)
	  | callStaticLink (a, EMPTY, fp) = callStaticLink (a, outermost, fp)


	fun transSimpleVar (SOME(l1, a), l2): exp = Ex(F.exp a (staticLink (l1, l2, T.TEMP(F.FP))))
	  | transSimpleVar (NONE, l2): exp = (ErrorMsg.error 0 ("Var access not found."); Ex(T.CONST(0)))


	fun unEx (Ex(e), level) = e
	  | unEx (Nx(g), level) = T.ESEQ(g, T.CONST 0)
	  | unEx (Cx(f), level) = let
					  		val r = Temp.newtemp () (*register*)
					        val l1 = Temp.newlabel () (*label*)
					        val l2 = Temp.newlabel () (*label*)
					        val b = f (l1, l2)
					    in
					        T.ESEQ(
					            T.SEQ(
					                T.MOVE(T.TEMP r, T.CONST 0),
									T.SEQ(
					                	b,
										T.SEQ(
					                    	T.LABEL l1,
											T.SEQ(
					                    		T.MOVE(T.TEMP r, T.CONST 1),
					                    		T.LABEL l2
											)
										)
									)
					            ),
					            T.TEMP r
					        )
					    end

	fun unNx(Ex(e)) = T.EXP(e)
	  | unNx(Nx(g)) = g
	  | unNx(Cx(f)) =
	    let
			val l1 = Temp.newlabel()
	    in
	        T.SEQ(f(l1,l1), T.LABEL l1)
	    end

	fun unCx(Ex(T.CONST (0)), level) = (fn (l1, l2) => T.JUMP(T.NAME(l2), [l2]))
	  | unCx(Ex(T.CONST (_)), level) = (fn (l1, l2) => T.JUMP(T.NAME(l1), [l1]))
	  | unCx(Ex(e), level) = let
	  						val t1 = T.TEMP(Temp.newtemp ())
	  					in
							(fn (l1, l2) => T.SEQ(T.MOVE(t1, e),  T.CJUMP(T.NE, t1, T.CONST(0), l1, l2)))
						end
	  | unCx(Nx(g), level) = (ErrorMsg.error 0 ("UnCx an Nx? Stop that."); (fn (l1, l2) => T.SEQ(g,  T.JUMP(T.NAME(l1), [l1]))))
	  | unCx(Cx(f), level) = f

	fun transRecordVar (exp, index, level) =
		Ex(
			T.MEM(
			T.BINOP(
				T.PLUS,
				T.CONST(index * F.wordSize),
				unEx(exp, level)
			)
		)
		)

  	fun transArrayVar (exp, index, level): exp = 	let
  												val id = Temp.newtemp ()
  												val loc = Temp.newtemp ()
  												val pass = Temp.newlabel()
  												val exit = Temp.newlabel()
  												val access = Temp.newlabel()
  											in
  												Ex(
  													T.ESEQ(
  														T.SEQ(
  															T.SEQ(
  																T.SEQ(
  																	T.MOVE(T.TEMP(id), unEx(index, level)),
  																	T.MOVE(T.TEMP(loc), unEx(exp, level))
  																),
  																T.SEQ(
  																	T.CJUMP(T.GE, T.TEMP(id), T.CONST(0), pass, exit),
  																	T.SEQ(
  																		T.LABEL(pass),
  																		T.CJUMP(T.LT, T.TEMP(id), T.MEM(T.BINOP(T.MINUS, T.TEMP(loc), T.CONST(F.wordSize))), access, exit)
  																	)
  																)
  															),
  															T.SEQ(
  																T.LABEL(exit),
  																unNx(Ex(F.externalCall("tig_exit", [T.CONST(1)])))
  															)
  														),
  														T.ESEQ(
  															T.LABEL(access),
  															T.MEM(T.BINOP(T.PLUS, T.BINOP(T.MUL, T.TEMP(id), T.CONST(F.wordSize)), T.TEMP(loc)))
  														)
  													)
  												)
  											end




	fun transIf(e1, e2, SOME(e3), level) =
	    let
	        val i1 = unCx (e1, level)
	        val i2 = unEx (e2, level)
	        val i3 = unEx (e3, level)
	        val t = Temp.newlabel()
	        val f = Temp.newlabel()
	        val e = Temp.newlabel()
	        val r = Temp.newtemp ()
	    in
			Ex(
				T.ESEQ(
					T.SEQ (
						i1 (t, f),
						T.SEQ (
							T.SEQ (
								T.LABEL t,
								T.SEQ (
									T.MOVE(T.TEMP r, i2),
									T.JUMP(T.NAME e, [e])
								)
							),
							T.SEQ (
								T.LABEL f,
								T.SEQ (
									T.MOVE(T.TEMP r, i3),
									T.JUMP(T.NAME e, [e])
								)
							)
						)
					),
					T.ESEQ (
						T.LABEL e,
						T.TEMP(r)
					)
				)
			)
	    end

		  | transIf(e1, e2, NONE, level) =
		    let
		        val i1 = unCx (e1, level)
		        val i2 = unEx (e2, level)
		        val t = Temp.newlabel()
		        val e = Temp.newlabel()
		        val r = Temp.newtemp ()
		    in
				Ex(
		        T.ESEQ(
					T.SEQ (
						i1 (t, e),
						T.SEQ (
							T.LABEL t,
							T.SEQ (
								T.MOVE(T.TEMP r, i2),
								T.JUMP(T.NAME e, [e])
							)
						)
					),
					T.ESEQ (
						T.LABEL e,
						T.TEMP(r)
					)
				)
				)
		    end

	fun transWhile(e1, e2, ed, level) = let
								val i1 = unCx (e1, level)
								val i2 = unNx (e2)
								val cond = Temp.newlabel()
								val body = Temp.newlabel()
							 in
							 	Nx(
							 		T.SEQ (
										T.SEQ (
											T.SEQ (
												T.LABEL cond,
												i1 (body, ed)
											),
											T.SEQ (
												T.LABEL body,
												T.SEQ (
													i2,
													T.JUMP(T.NAME cond, [cond])
												)
											)
										),
										T.LABEL (ed)
									)
								)
							 end

	 fun transFor(hi, lo, body, ed, level) = let
									val i1 = unNx body
									val i2 = unEx (hi, level)
									val i3 = unEx (lo, level)
									val h = Temp.newtemp ()
									val l = Temp.newtemp ()
									val cond = Temp.newlabel()
									val body = Temp.newlabel()
								 in
								 	Nx(
									 T.SEQ (
										 T.SEQ (
											 T.MOVE (T.TEMP h, i2),
											 T.MOVE (T.TEMP l, i3)
										),
										T.SEQ (
											T.SEQ (
												T.SEQ (
													T.LABEL cond,
													T.CJUMP(T.LT, T.TEMP l, T.TEMP h, body, ed)
											 	),
												T.SEQ (
													T.LABEL body,
													T.SEQ (
														T.MOVE(T.TEMP l, T.BINOP(T.PLUS, T.TEMP l, T.CONST 1)),
														T.SEQ (
															i1,
															T.JUMP(T.NAME cond, [cond])
														)
													)
											 	)
										 	),
										 	T.LABEL ed
										 )
								 	 )
									 )
								end
	fun beginLoop () = Temp.newlabel()
	fun transNil () = Ex(T.CONST 0)
	fun transInt i = Ex(T.CONST i)

	fun loadString l =
		let
			val t = T.TEMP (Temp.newtemp ())
		in
			T.ESEQ(T.MOVE(t, T.NAME(l)), t)
		end

	fun transString s = let
							val lab = Temp.newlabel ()
							(* put F.String(lab, s) onto frag list*)
						in
							fragList := F.STRING(lab, s)::(!fragList);
							Ex(loadString lab)
						end
	fun transCall (l, args, SOME(callee), caller) = Ex(T.CALL (T.NAME l, (callStaticLink (caller, callee, (T.TEMP F.FP)))::(map (fn a => unEx(a, caller)) args)))
	  | transCall (l, args, NONE, caller) = Ex(T.CALL (T.NAME l, (T.TEMP F.FP)::(map (fn a => unEx(a, caller)) args)))

	fun transRel (oper, ex1, ex2, resultT, resultF) = let
														val result = Temp.newtemp ()
														val t = Temp.newlabel ()
														val f = Temp.newlabel ()
														val e = Temp.newlabel ()
													  in
													  	Ex(
															T.ESEQ(
																T.SEQ(
																	T.CJUMP(oper, ex1, ex2, t, f),
																	T.SEQ(
																		T.SEQ(
																			T.LABEL(t),
																			T.SEQ(
																				T.MOVE(
																					T.TEMP(result),
																					resultT)
																				,
																				T.JUMP(T.NAME(e), [e]))),
																		T.SEQ(
																			T.LABEL(f),
																			T.SEQ(
																				T.MOVE(
																					T.TEMP(result),
																					resultF)
																				,
																				T.JUMP(T.NAME(e), [e])))
																		)
																	),
																T.ESEQ(
																	T.LABEL(e),
																	T.TEMP(result)
																	)
																)
															)
													  end


	fun transOP (A.PlusOp, e1, e2, level) 	 = Ex(T.BINOP(T.PLUS, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.MinusOp, e1, e2, level)	 = Ex(T.BINOP(T.MINUS, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.TimesOp, e1, e2, level)	 = Ex(T.BINOP(T.MUL, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.DivideOp, e1, e2, level)  = Ex(T.BINOP(T.DIV, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.EqOp, Ex(T.NAME n1), Ex(T.NAME n2), level)	= Ex(T.CALL(T.NAME(Temp.namedlabel("tig_stringEqual")), [loadString n1, loadString n2]))
	  | transOP (A.EqOp, e1, Ex(T.NAME n), level)			= Ex(T.CALL(T.NAME(Temp.namedlabel("tig_stringEqual")), [unEx(e1, level), loadString n]))
	  | transOP (A.EqOp, Ex(T.NAME n), e2, level)			= Ex(T.CALL(T.NAME(Temp.namedlabel("tig_stringEqual")), [unEx(e2, level), loadString n]))
	  | transOP (A.EqOp, e1, e2, level) 	 = transRel(T.EQ, unEx(e1, level), unEx(e2, level), T.CONST 1, T.CONST 0)
	  | transOP (A.NeqOp, e1, e2, level) 	 = transRel(T.NE, unEx(e1, level), unEx(e2, level), T.CONST 1, T.CONST 0)
	  | transOP (A.LtOp, e1, e2, level) 	 = transRel(T.LT, unEx(e1, level), unEx(e2, level), T.CONST 1, T.CONST 0)
	  | transOP (A.LeOp, e1, e2, level) 	 = transRel(T.LE, unEx(e1, level), unEx(e2, level), T.CONST 1, T.CONST 0)
	  | transOP (A.GtOp, e1, e2, level) 	 = transRel(T.GT, unEx(e1, level), unEx(e2, level), T.CONST 1, T.CONST 0)
	  | transOP (A.GeOp, e1, e2, level) 	 = transRel(T.GE, unEx(e1, level), unEx(e2, level), T.CONST 1, T.CONST 0)

	fun transSeq (a::[], level) = Ex(unEx(a, level))
	  | transSeq (a::l, level) = Ex(T.ESEQ(unNx(a), unEx(transSeq(l, level), level)))
	  | transSeq ([], level) = Ex(T.CONST(0))
	fun transLet (d::decs, body, level) = Ex(T.ESEQ(unNx(d), unEx(transLet(decs, body, level), level)))
	  | transLet ([], body, level) = Ex(unEx(body, level))

	fun addRecVal level (a::[], i) = T.MOVE (T.MEM (T.BINOP (T.PLUS, T.TEMP F.V0, T.CONST (i * 4))), unEx(a, level))
	  | addRecVal level (a::l, i) = T.SEQ(T.MOVE (T.MEM (T.BINOP (T.PLUS, T.TEMP F.V0, T.CONST (i * 4))), unEx(a, level)), addRecVal level (l, i + 1))
	  | addRecVal level ([], i) = T.EXP(T.CONST 0)

	fun transRec (lst, level) =
		let
			val result = Temp.newtemp ()
		in
			Ex (
				T.ESEQ (
					T.MOVE ( T.TEMP result, T.CALL(T.NAME(Temp.namedlabel("tig_allocRecord")), [T.CONST (List.length(lst) * 4)])),
					T.ESEQ (
							addRecVal level (lst, 0),
							T.TEMP result
						)
					)
				)
		end
	fun transArray (size, init, level) =
	let
		val t = T.TEMP (Temp.newtemp ())
		val size = unEx(size, level)
	in
		Ex(T.ESEQ(
				T.SEQ(
					T.MOVE(t, T.CALL(
								T.NAME(Temp.namedlabel("tig_initArray")),
								[T.BINOP(T.PLUS, size, T.CONST 1), unEx(init, level)])),
					T.MOVE(T.MEM(t), size)),
				T.BINOP(T.PLUS, t, T.CONST(F.wordSize))))
	end

	fun transAssign (var, exp, level) = Nx(T.MOVE (unEx(var, level) , unEx(exp, level)))
	fun transBreak (label) = Nx(T.JUMP(T.NAME(label), [label]))

	fun getLoc 0 = T.TEMP F.A0
	  | getLoc 1 = T.TEMP F.FP
	  | getLoc 2 = T.TEMP F.A1
	  | getLoc 3 = T.TEMP F.A2
	  | getLoc 4 = T.TEMP F.A3
	  | getLoc i = T.MEM (T.BINOP (T.PLUS, T.TEMP F.FP, T.CONST(4 * i)))

	fun moveArgs size (i, (F.InReg t)::l) = T.SEQ(T.MOVE (T.TEMP t, getLoc i), moveArgs size ((i + 1), l))
	  | moveArgs size (i, (F.InFrame j)::l) = T.SEQ(T.MOVE (T.MEM (T.BINOP (T.MINUS, T.TEMP F.SP, T.CONST(j))), getLoc i), moveArgs size ((i + 1), l))
	  | moveArgs size (i, []) = T.EXP(T.CONST 0)

	fun toStack (i, t::[]) = T.MOVE(T.MEM (T.BINOP (T.MINUS, T.TEMP F.SP, T.CONST (i))), T.TEMP t)
	  | toStack (i, t::l) = T.SEQ(T.MOVE(T.MEM (T.BINOP (T.MINUS, T.TEMP F.SP, T.CONST (i))), T.TEMP t), toStack (i + 4, l))
	  | toStack (i, []) = T.EXP(T.CONST 0)

	fun fromStack (i, t::[]) = T.MOVE(T.TEMP t, T.MEM (T.BINOP (T.MINUS, T.TEMP F.SP, T.CONST (i))))
	  | fromStack  (i, t::l) = T.SEQ(T.MOVE(T.TEMP t, T.MEM (T.BINOP (T.MINUS, T.TEMP F.SP, T.CONST (i)))), fromStack (i + 4, l))
	  | fromStack (i, []) = T.EXP(T.CONST 0)

	val calleesaves = (F.getTemps F.calleesaves)@[F.RA]
	fun saveCallees () = T.SEQ(toStack (0, calleesaves), T.MOVE(T.TEMP F.SP, T.BINOP (T.MINUS, T.TEMP F.SP, T.CONST(4 * (List.length calleesaves)))))
	fun restoreCallees () = T.SEQ(T.MOVE(T.TEMP F.SP, T.BINOP (T.PLUS, T.TEMP F.SP, T.CONST(4 * (List.length calleesaves)))), fromStack (0, calleesaves))

	fun procEntry (formList, frame) =
		T.SEQ(
			moveArgs (F.size frame) (0, formList),
			T.SEQ(
				T.SEQ(
					T.MOVE(T.TEMP F.FP, T.TEMP F.SP),
					T.MOVE(T.TEMP F.SP, T.BINOP (T.MINUS, T.TEMP F.SP, T.CONST (F.size frame)))
					),
				saveCallees ())
		)

	fun procExit frame =
		T.SEQ(
			restoreCallees (),
			T.SEQ(
				T.MOVE(T.TEMP F.SP, T.TEMP F.FP),
				T.MOVE(T.TEMP F.FP, T.MEM(T.BINOP (T.MINUS, T.TEMP F.FP, T.CONST 4)))
				))

	fun getFormals (L(frame, p, u)) = F.formals frame
	  | getFormals (EMPTY) = []

	fun transBody (exp, formList, L(frame, p, u)) =
		Nx(
			T.SEQ(
				T.LABEL(F.label frame),
				T.SEQ(
					procEntry (formList, frame),
					T.SEQ(
						unNx(transAssign (Ex(T.TEMP F.V0), exp, L(frame, p, u))),
						T.SEQ(
							procExit frame,
							T.JUMP(T.TEMP (F.RA), []))))))
	  | transBody (exp, formList, EMPTY) =
	  	Nx(
			T.SEQ(
				T.LABEL(Temp.newlabel ()),
				T.SEQ(
					procEntry (formList, (getFrame EMPTY)),
					T.SEQ(
						unNx(transAssign (Ex(T.TEMP F.V0), exp, EMPTY)),
						T.SEQ(
							procExit (getFrame EMPTY),
							T.JUMP(T.TEMP (F.RA), []))))))
	fun transProc (exp, formList, L(frame, p, u)) =
		Nx(
			T.SEQ(
				T.LABEL(F.label frame),
				T.SEQ(
					procEntry (formList, frame),
					T.SEQ(
						unNx(exp),
						T.SEQ(
							procExit frame,
							T.JUMP(T.TEMP (F.RA), []))))))
	  | transProc (exp, formlist, EMPTY) =
	  	Nx(
			T.SEQ(
				T.LABEL(Temp.newlabel ()),
				T.SEQ(
					procEntry (formlist, (getFrame EMPTY)),
					T.SEQ(
						 unNx(exp),
						 T.SEQ(
 							procExit (getFrame EMPTY),
						 	T.JUMP(T.TEMP (F.RA), []))))))


	fun procEntryExit {level=L(f,_,_), body=body} = (fragList := !fragList@[F.PROC({body=F.procEntryExit1(f, unNx(body)), frame=f})]; ())
	  | procEntryExit {level=EMPTY, body=body} = ()

	fun treeExp a = unEx a

	fun frag (L(frame, a, u), formList, Ex(exp)) = F.PROC{body=
		T.SEQ(
			T.LABEL(F.label frame),
			T.SEQ(
				procEntry (formList, frame),
				T.SEQ(
					T.MOVE(T.TEMP (F.V0), exp),
					T.SEQ(
						procExit frame,
						T.EXP(T.CALL(T.NAME(Temp.namedlabel("tig_exit")), [T.CONST(0)])))))), frame=frame}
	  | frag (L(frame, a, u), formList, Nx(stm)) = F.PROC{body=
		T.SEQ(
			T.LABEL(F.label frame),
			T.SEQ(
				procEntry (formList, frame),
				T.SEQ(
					stm,
					T.SEQ(
						procExit frame,
						T.EXP(T.CALL(T.NAME(Temp.namedlabel("tig_exit")), [T.CONST(0)])))))), frame=frame}
	  | frag (L(frame, a, u), formList, Cx(cond)) = F.PROC{body=
		T.SEQ(
			T.LABEL(F.label frame),
			T.SEQ(
				procEntry (formList, frame),
				T.SEQ(
					T.MOVE(T.TEMP (F.V0), unEx(Cx(cond), L(frame, a, u))),
					T.SEQ(
						procExit frame,
						T.EXP(T.CALL(T.NAME(Temp.namedlabel("tig_exit")), [T.CONST(0)])))))), frame=frame}
	  | frag (EMPTY, formList, exp) = frag (outermost, formList, exp)

end

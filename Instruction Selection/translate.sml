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

	val fragList: F.frag list ref = ref []

	fun getResult () = let val result = !fragList in fragList := []; result end

	fun getLevelInfo (L(frame, p, u)) = (map (fn frameAccess => (L(frame, p, u) , frameAccess)) (F.formals frame), (F.label frame))
	  | getLevelInfo EMPTY = ([], Temp.newlabel ())

	fun newLevel {parent=parent, name=name, formals=formals} = let
																	val n = F.newFrame {name=name, formals=true::formals}
															   in
															   		L(n, parent, ref ())
															   end

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

	fun transSimpleVar (SOME(l1, a), l2): exp = Ex(F.exp a (staticLink (l1, l2, T.TEMP(F.FP))))
	  | transSimpleVar (NONE, l2): exp = (ErrorMsg.error 0 ("Var access not found."); Ex(T.CONST(0)))


	fun unEx (Ex(e), level) = e
	  | unEx (Nx(g), level) = T.ESEQ(g, T.CONST 0)
	  | unEx (Cx(f), level) = let
					  		val r = #temp (allocTemp (level)) (*register*)
					        val l1 = Temp.newlabel() (*label*)
					        val l2 = Temp.newlabel() (*label*)
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
	  						val t1 = T.TEMP(#temp (allocTemp level))
	  					in
							(fn (l1, l2) => T.SEQ(T.MOVE(t1, e),  T.CJUMP(T.NE, t1, T.CONST(0), l1, l2)))
						end
	  | unCx(Nx(g), level) = (ErrorMsg.error 0 ("UnCx an Nx? Stop that."); (fn (l1, l2) => T.SEQ(g,  T.JUMP(T.NAME(l1), [l1]))))
	  | unCx(Cx(f), level) = f

	fun transRecordVar (exp, index, level) = Ex(
  		  								T.MEM(
  											T.BINOP(
  												T.PLUS,
  												T.BINOP(
  													T.MUL, T.CONST(index), T.CONST(F.wordSize)),
  												unEx(exp, level)
  											)
  										)
  		  							)

  	fun transArrayVar (exp, index, level): exp = 	let
  												val id = #temp (allocTemp level)
  												val loc = #temp (allocTemp level)
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
  																unNx(Ex(F.externalCall("exit", [T.CONST(1)])))
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
	        val r = #temp (allocTemp level)
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
		        val r = #temp (allocTemp level)
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
									val h = #temp (allocTemp level)
									val l = #temp (allocTemp level)
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
	fun transString s = let
							val lab = Temp.newlabel ()
							(* put F.String(lab, s) onto frag list*)
						in
							fragList := F.STRING(lab, s)::(!fragList);
							Ex(T.NAME(lab))
						end
	fun transCall (l, args, level) = Ex(T.CALL (T.NAME l, (T.TEMP F.FP)::(map (fn a => unEx(a, level)) args)))
	fun transOP (A.PlusOp, e1, e2, level) 	 = Ex(T.BINOP(T.PLUS, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.MinusOp, e1, e2, level)	 = Ex(T.BINOP(T.MINUS, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.TimesOp, e1, e2, level)	 = Ex(T.BINOP(T.MUL, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.DivideOp, e1, e2, level) = Ex(T.BINOP(T.DIV, unEx(e1, level), unEx(e2, level)))
	  | transOP (A.EqOp, e1, e2, level) 	 = transIf(Ex(T.BINOP(T.MINUS, unEx(e1, level), unEx(e2, level))), Ex(T.CONST 0), SOME(Ex(T.CONST 1)), level)
	  | transOP (A.NeqOp, e1, e2, level) 	 = transIf(Ex(T.BINOP(T.MINUS, unEx(e1, level), unEx(e2, level))), Ex(T.CONST 1), SOME(Ex(T.CONST 0)), level)
	  | transOP (A.LtOp, e1, e2, level) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e1, level), unEx(e2, level)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 1), SOME(Ex(T.CONST 0)), level)
	  | transOP (A.LeOp, e1, e2, level) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e2, level), unEx(e1, level)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 0), SOME(Ex(T.CONST 1)), level)
	  | transOP (A.GtOp, e1, e2, level) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e1, level), unEx(e2, level)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 0), SOME(Ex(T.CONST 1)), level)
	  | transOP (A.GeOp, e1, e2, level) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e2, level), unEx(e1, level)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 1), SOME(Ex(T.CONST 0)), level)

	fun transSeq (a::[], level) = Ex(unEx(a, level))
	  | transSeq (a::l, level) = Ex(T.ESEQ(unNx(a), unEx(transSeq(l, level), level)))
	  | transSeq ([], level) = Ex(T.CONST(0))
	fun transLet (d::decs, body, level) = Ex(T.ESEQ(unNx(d), unEx(transLet(decs, body, level), level)))
	  | transLet ([], body, level) = Ex(unEx(body, level))
	fun transRec (lst, level) = Ex(T.CALL(T.NAME(Temp.namedlabel("allocRecord")), (map (fn a => unEx(a, level)) lst)))
	fun transArray (size, init, level) = Ex(T.CALL(T.NAME(Temp.namedlabel("initArray")), [T.BINOP(T.MUL, unEx(size, level), T.CONST(F.wordSize)), unEx(init, level)]))
	fun transAssign (var, exp, level) = Nx(T.MOVE (unEx(var, level) , unEx(exp, level)))
	fun transBreak (label) = Nx(T.JUMP(T.NAME(label), [label]))
	fun transBody (exp, L(frame, p, u)) = Nx(T.SEQ(T.SEQ(T.LABEL(F.label frame), unNx(transAssign (Ex(T.TEMP F.V0), exp, L(frame, p, u)))), T.JUMP(T.TEMP (F.RA), [])))
	  | transBody (exp, EMPTY) =  Nx(T.SEQ(T.SEQ(T.LABEL(Temp.newlabel ()), unNx(transAssign (Ex(T.TEMP F.V0), exp, EMPTY))), T.JUMP(T.TEMP (F.RA), [])))
	fun transProc (exp, L(frame, p, u)) = Nx(T.SEQ(T.SEQ(T.LABEL(F.label frame), unNx(exp)), T.JUMP(T.TEMP (F.RA), [])))
	  | transProc (exp, EMPTY) = Nx(T.SEQ(T.SEQ(T.LABEL(Temp.newlabel ()), unNx(exp)), T.JUMP(T.TEMP (F.RA), [])))


	fun procEntryExit {level=L(f,_,_), body=body} = (fragList := !fragList@[F.PROC({body=F.procEntryExit1(f, unNx(body)), frame=f})]; ())
	  | procEntryExit {level=EMPTY, body=body} = ()

	fun treeStm a = unNx a

	fun frag (L(frame, a, u), stm) = F.PROC{body=T.SEQ(T.LABEL(F.label frame), stm), frame=frame}
	  | frag (EMPTY, exp) = frag (outermost, exp)

end

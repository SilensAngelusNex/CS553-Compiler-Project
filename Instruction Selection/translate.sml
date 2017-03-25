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

	val currLevel = ref (L(F.newFrame {name=Temp.newlabel (), formals=[true]}, EMPTY, ref ()))

	val outermost = !currLevel

	val fragList: F.frag list ref = ref []

	fun getResult () = !fragList

	fun newLevel {parent=parent, name=name, formals=formals} = let
																	val n = F.newFrame {name=name, formals=true::formals}
																	val u = ref ()
																	val result = L(n, parent, ref ())
															   in
															   		currLevel := result;
																	result
															   end

    fun allocTemp () = case !currLevel of L(f, _, _) => F.allocTemp f
   						  | EMPTY => (newLevel {parent=EMPTY, name=Temp.newlabel (), formals=[true]}; allocTemp ())

	fun leaveLevel () = (currLevel := (case !currLevel of
									L(_, EMPTY, _) => L(F.newFrame {name=Temp.newlabel (), formals=[true]}, EMPTY, ref ())
									| L(_, p, _) => p
									| EMPTY => L(F.newFrame {name=Temp.newlabel (), formals=[true]}, EMPTY, ref ()));
						!currLevel)


	fun formals (L(frame, a, u)): access list = (case F.formals frame of
													c::l => (map (fn b => (L(frame, a, u), b)) l)
												   | []  => [])

	  | formals EMPTY: access list = []

	fun allocLocal (L(frame, p, u)) bool = (L(frame, p, u), F.allocLocal frame bool)
	  | allocLocal EMPTY bool = (!currLevel, F.allocLocal (F.newFrame {name= Temp.newlabel (), formals= []}) bool)

	fun staticLink (L(f1, p1, u1), L(f2, p2, u2), link) = (case u1 = u2 of
															true => link
															| false => staticLink (L(f1, p1, u1), p2, T.MEM(link)))
	  | staticLink (EMPTY, L(f2, p2, u2), link) = staticLink (EMPTY, p2, T.MEM(link))
	  | staticLink (L(f1, p1, u1), EMPTY, link) = (ErrorMsg.error 0 ("Static link not found."); link)
	  | staticLink (EMPTY, EMPTY, link) = link

	fun transSimpleVar (SOME(l1, a), l2): exp = Ex(F.exp a (staticLink (l1, l2, T.TEMP(F.FP))))
	  | transSimpleVar (NONE, l2): exp = (ErrorMsg.error 0 ("Var access not found."); Ex(T.CONST(0)))


	fun unEx (Ex(e)) = e
	  | unEx (Nx(g)) = T.ESEQ(g, T.CONST 0)
	  | unEx (Cx(f)) = let
					  		val r = allocTemp () (*register*)
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

	fun unCx(Ex(T.CONST (0))) = (fn (l1, l2) => T.JUMP(T.NAME(l2), [l2]))
	  | unCx(Ex(T.CONST (_))) = (fn (l1, l2) => T.JUMP(T.NAME(l1), [l1]))
	  | unCx(Ex(e)) = let
	  						val t1 = T.TEMP(allocTemp ())
	  					in
							(fn (l1, l2) => T.SEQ(T.MOVE(t1, e),  T.CJUMP(T.NE, t1, T.CONST(0), l1, l2)))
						end
	  | unCx(Nx(g)) = (ErrorMsg.error 0 ("UnCx an Nx? Stop that."); (fn (l1, l2) => T.SEQ(g,  T.JUMP(T.NAME(l1), [l1]))))
	  | unCx(Cx(f)) = f

	fun transRecordVar (exp, index) = Ex(
  		  								T.MEM(
  											T.BINOP(
  												T.PLUS,
  												T.BINOP(
  													T.MUL, T.CONST(index), T.CONST(F.wordSize)),
  												unEx(exp)
  											)
  										)
  		  							)

  	fun transArrayVar (exp, index): exp = 	let
  												val id = allocTemp ()
  												val loc = allocTemp ()
  												val pass = Temp.newlabel()
  												val exit = Temp.newlabel()
  												val access = Temp.newlabel()
  											in
  												Ex(
  													T.ESEQ(
  														T.SEQ(
  															T.SEQ(
  																T.SEQ(
  																	T.MOVE(T.TEMP(id), unEx(index)),
  																	T.MOVE(T.TEMP(loc), unEx(exp))
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




	fun transIf(e1, e2, SOME(e3)) =
	    let
	        val i1 = unCx e1
	        val i2 = unEx e2
	        val i3 = unEx e3
	        val t = Temp.newlabel()
	        val f = Temp.newlabel()
	        val e = Temp.newlabel()
	        val r = allocTemp ()
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

		  | transIf(e1, e2, NONE) =
		    let
		        val i1 = unCx e1
		        val i2 = unEx e2
		        val t = Temp.newlabel()
		        val e = Temp.newlabel()
		        val r = allocTemp ()
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

	fun transWhile(e1, e2, ed) = let
								val i1 = unCx e1
								val i2 = unNx e2
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

	 fun transFor(hi, lo, body, ed) = let
									val i1 = unNx body
									val i2 = unEx hi
									val i3 = unEx lo
									val h = allocTemp ()
									val l = allocTemp ()
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
							fragList := !fragList@[F.STRING(lab, s)];
							Ex(T.NAME(lab))
						end
	fun transCall (l, args) = Ex(T.CALL (T.NAME l, (T.TEMP F.FP)::(map unEx args)))
	fun transOP (A.PlusOp, e1, e2) 	 = Ex(T.BINOP(T.PLUS, unEx(e1), unEx(e2)))
	  | transOP (A.MinusOp, e1, e2)	 = Ex(T.BINOP(T.MINUS, unEx(e1), unEx(e2)))
	  | transOP (A.TimesOp, e1, e2)	 = Ex(T.BINOP(T.MUL, unEx(e1), unEx(e2)))
	  | transOP (A.DivideOp, e1, e2) = Ex(T.BINOP(T.DIV, unEx(e1), unEx(e2)))
	  | transOP (A.EqOp, e1, e2) 	 = transIf(Ex(T.BINOP(T.MINUS, unEx(e1), unEx(e2))), Ex(T.CONST 0), SOME(Ex(T.CONST 1)))
	  | transOP (A.NeqOp, e1, e2) 	 = transIf(Ex(T.BINOP(T.MINUS, unEx(e1), unEx(e2))), Ex(T.CONST 1), SOME(Ex(T.CONST 0)))
	  | transOP (A.LtOp, e1, e2) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e1), unEx(e2)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 1), SOME(Ex(T.CONST 0)))
	  | transOP (A.LeOp, e1, e2) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e2), unEx(e1)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 0), SOME(Ex(T.CONST 1)))
	  | transOP (A.GtOp, e1, e2) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e1), unEx(e2)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 0), SOME(Ex(T.CONST 1)))
	  | transOP (A.GeOp, e1, e2) 	 = transIf(Ex(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, unEx(e2), unEx(e1)), T.CONST(F.wordSize * 8 - 1))), Ex(T.CONST 1), SOME(Ex(T.CONST 0)))

	fun transSeq (a::[]) = Ex(unEx(a))
	  | transSeq (a::l) = Ex(T.ESEQ(unNx(a), unEx(transSeq(l))))
	  | transSeq ([]) = Ex(T.CONST(0))
	fun transLet (d::decs, body) = Ex(T.ESEQ(unNx(d), unEx(transLet(decs, body))))
	  | transLet ([], body) = Ex(unEx(body))
	fun transRec (lst) = Ex(T.CALL(T.NAME(Temp.namedlabel("allocRecord")), (map unEx lst)))
	fun transArray (size, init) = Ex(T.CALL(T.NAME(Temp.namedlabel("initArray")), [T.BINOP(T.MUL, unEx(size), T.CONST(F.wordSize)), unEx(init)]))
	fun transAssign (var, exp) = Nx(T.MOVE (unEx(var) , unEx(exp)))
	fun transBreak (label) = Nx(T.JUMP(T.NAME(label), [label]))
	fun transBody (exp) = transAssign (Ex(T.TEMP F.RV), exp)


	fun procEntryExit {level=L(f,_,_), body=body} = (fragList := !fragList@[F.PROC({body=F.procEntryExit1(f, unNx(body)), frame=f})]; ())
	  | procEntryExit {level=EMPTY, body=body} = ()

	fun treeStm a = unNx a
end

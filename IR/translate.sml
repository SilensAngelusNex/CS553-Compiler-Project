structure Translate: TRANSLATE =
struct

	structure M = MIPSFrame

	structure T = Tree

	datatype exp = Ex of Tree.exp
				 | Nx of Tree.stm
				 | Cx of Temp.label * Temp.label -> Tree.stm

	datatype level = L of M.frame * level * unit ref
					| EMPTY

	type access = level * M.access

	val currLevel = ref EMPTY

	val outermost = !currLevel

	fun newLevel {parent=parent, name=name, formals=formals} = let
																	val n = M.newFrame {name=name, formals=true::formals}
																	val u = unit ref
																	val result = L(n, parent, unit ref)
															   in
															   		currLevel := result;
																	result
															   end

	fun formals (L(frame, _, u)): access list = (case M.formals frame of
													a::l => (map (fn b => (L(frame, _, u), b)) l)
												   | []  => [])

	  | formals EMPTY: access list = []

	fun allocLocal (L(frame, _, u)) bool = (!currLevel, M.allocLocal frame bool)
	  | allocLocal EMPTY bool = (!currLevel, M.allocLocal (M.newFrame {name= Temp.newlabel (), formals= []}) bool)

	fun staticLink (L(f1, p1, u1), L(f2, p2, u2)) link = case u1 = u2 of
												true => link
												| false => staticLink (L(f1, p1, u1), p2) T.MEM(link)

	fun simpleVar (SOME(l1, a), l2): exp = M.exp a (staticLink (l1, l2) M.FP)
	  | simpleVar (NONE, l2): exp = (ErrorMsg.error 0 ("Var access not found."); T.CONST(0))

	fun unEx(Ex, e) = e
	  | unEx(Nx, g) = ESEQ(s, CONST 0)
	  | unEx(Cx, f) =
	    let val r = Temp.newtemp() (*register*)
	        val l1 = Temp.newlabel() (*label*)
	        val l2 = Temp.newlabel() (*label*)
	        val b = f (l1, l2)
	    in
	        ESEQ(
	            seq([
	                    MOVE(TEMP R, CONST 0),
	                    b,
	                    LABEL l1,
	                    MOVE(TEMP R, CONST 1),
	                    LABEL l2
	                  ]),
	             TEMP r
	             )
	    end

	fun unNx(Ex, e) = EXP(e)
	  | unNx(Nx, g) = g
	  | unNx(Cx, f) =
	    let l1 = newLabel()
	    in
	        SEQ(f(l1,l1, Label l1))
	    end

	fun unCx(Ex(T.CONST (0))) = (fn (l1, l2) => T.JUMP(T.NAME(l2), [l2]))
	  | unCx(Ex(T.CONST (_))) = (fn (l1, l2) => T.JUMP(T.NAME(l1), [l1]))
	  | unCx(Ex(e)) = let
	  						val t1 = T.TEMP(Temp.newtemp())
	  					in
							(fn (l1, l2) => T.SEQ(T.MOVE(t1, e),  T.CJUMP(NEQ, t1, T.CONST(0), l1, l2)))
						end
	  | unCx(Nx(g)) = (ErrorMsg.error 0 ("UnCx an Nx? Stop that."); (fn (l1, l2) => T.SEQ(g,  T.JUMP(T.NAME(l1), [l1]))))
	  | unCx(Cx(f)) = f


	fun transIf(e1, e2, SOME(e3)) =
	    let
	        val i1 = unCx e1
	        val i2 = unEx e2
	        val i3 = unEx e3
	        val t = Temp.newlabel()
	        val f = Temp.newlabel()
	        val e = Temp.newlabel()
	        val r = Temp.newtemp()
	    in
	        T.ESEQ(
				T.SEQ (
					i1 (t, f),
					T.SEQ (
						T.SEQ (
							T.LABEL t,
							T.SEQ (
								T.MOVE(TEMP r, i2),
								T.JUMP(NAME e, [e])
							)
						)
						T.SEQ (
							T.LABEL f,
							T.SEQ (
								T.MOVE(TEMP r, i3),
								T.JUMP(NAME e, [e])
							)
						)
					)
				),
				T.ESEQ (
					T.LABEL e,
					T.TEMP(r)
				)
			)
	    end

		  | transIf(e1, e2, NONE) =
		    let
		        val i1 = unCx e1
		        val i2 = unEx e2
		        val t = Temp.newlabel()
		        val e = Temp.newlabel()
		        val r = Temp.newtemp()
		    in
		        T.ESEQ(
					T.SEQ (
						i1 (t, e),
						T.SEQ (
							T.LABEL t,
							T.SEQ (
								T.MOVE(TEMP r, i2),
								T.JUMP(NAME e, [e])
							)
						)
					),
					T.ESEQ (
						T.LABEL e,
						T.TEMP(r)
					)
				)
		    end

	fun transWhile(e1, e2) = let
								val i1 = unCx e1
								val i2 = unNx e2
								val cond = Temp.newlabel()
								val body = Temp.newlabel()
								val ed = Temp.newlabel()
							 in
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
												T.JUMP(NAME cond, [cond])
											)
										),
									),
									T.LABEL ed
								)
							 end

	 fun transFor(hi, lo, body) = let
									val i1 = unNx body
									val i2 = unEx hi
									val i3 = unEx lo
									val h = Temp.newtemp()
									val l = Temp.newtemp()
									val cond = Temp.newlabel()
									val body = Temp.newlabel()
									val ed = Temp.newlabel()
								 in
									 T.SEQ (
										 T.SEQ (
											 T.MOVE (T.TEMP h, i2),
											 T.MOVE (T.TEMP l, i3)
										),
										T.SEQ (
											T.SEQ (
												T.SEQ (
													T.LABEL cond,
													i1 (body, ed)
											 	),
												T.SEQ (
													T.LABEL body,
													T.SEQ (
														T.MOVE(T.TEMP l, T.BINOP(T.PLUS, T.TEMP l, T.CONST 1)),
														T.SEQ (
															i1,
															T.JUMP(NAME cond, [cond])
														)
													)
											 	)
										 	),
										 	T.LABEL ed
										 )
								 	 )
								end
	fun transNil () = CONST 0
	fun transInt i = CONST i
	fun transString s = let
							val lab = Temp.newlabel ()
							(* put Frame.String(lab, s) onto frag list*)
						in
							Tree.Name(lab)
						end
	fun transCall (l, args) = T.CALL (T.NAME l, (Temp M.FP)::args)
	fun transOP (A.PlusOp, e1, e2) 	 = T.BINOP(T.PLUS, e1, e2)
	  | transOP (A.MinusOp, e1, e2)	 = T.BINOP(T.MINUS, e1, e2)
	  | transOP (A.TimesOp, e1, e2)	 = T.BINOP(T.TIMES, e1, e2)
	  | transOP (A.DivideOp, e1, e2) = T.BINOP(T.DIVIDE, e1, e2)
	  | transOP (A.EqOp, e1, e2) 	 = transIf(T.BINOP(T.MINUS, e1, e2), T.CONST 0, T.CONST 1)
	  | transOP (A.NeqOp, e1, e2) 	 = transIf(T.BINOP(T.MINUS, e1, e2), T.CONST 1, T.CONST 0)
	  | transOP (A.LtOp, e1, e2) 	 = transIf(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, e1, e2), T.CONST(M.wordsize * 8 - 1)), T.CONST 1, T.CONST 0)
	  | transOP (A.LeOp, e1, e2) 	 = transIf(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, e2, e1), T.CONST(M.wordsize * 8 - 1)), T.CONST 0, T.CONST 1)
	  | transOP (A.GtOp, e1, e2) 	 = transIf(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, e1, e2), T.CONST(M.wordsize * 8 - 1)), T.CONST 0, T.CONST 1)
	  | transOP (A.GeOp, e1, e2) 	 = transIf(T.BINOP(T.RSHIFT, T.BINOP(T.MINUS, e2, e1), T.CONST(M.wordsize * 8 - 1)), T.CONST 1, T.CONST 0)

	fun transeSeq a::l = T.ESEQ(a, transeSeq(l))
				| a::nil = a
	fun transLet (d::decs, body) = T.ESEQ(d, transLet(decs, body))
	  | transLet ([], body) = body
	  | transLet (d::nil, body) = T.ESEQ(d, body)
	fun transRec (lst) = T.CALL(T.NAME(Temp.namedLabel("initRecord")), [lst])
	fun transArray (s, i) = T.CALL(T.NAME(Temp.namedLabel("initArray")), [T.BINOP(T.MUL, s, T.CONST(M.wordsize)), i])
	fun transAssign (var, exp) = T.MOVE (var , exp)
	fun transBreak = 
    (*
	fun transFuncDec of fundec list
    fun transVarDec of {name: symbol,
		    	escape: bool ref,
		    	typ: (symbol * pos) option,
		    	init: exp,
		    	pos: pos}
    fun transTypeDec of {name: symbol, ty: ty, pos: pos} list
	*)
end

structure Translate: TRANSLATE =
struct

	structure M = MIPSFrame

	structure Tree = Tree

	datatype exp = Ex of Tree.exp
				 | Nx of Tree.stm
				 | Cx of Temp.label * Temp.label -> Tree.stm

	datatype level = L of M.frame
					| EMPTY

	type access = level * M.access

	val currLevel = ref EMPTY

	val outermost = !currLevel

	fun newLevel {parent=parent, name=name, formals=formals} =  let
																		val n = M.newFrame {name=name, formals=true::formals}
																   in
																   		currLevel := L(n);
																		L(n)
																   end

	fun formals (L(frame)): access list = (case M.formals frame of
											a::l => (map (fn b => (L(frame), b)) l)
										   | []  => [])

	  | formals EMPTY: access list = []

	fun allocLocal (L(frame)) bool = (!currLevel, M.allocLocal frame bool)
	  | allocLocal EMPTY bool = (!currLevel, M.allocLocal (M.newFrame {name= Temp.newlabel (), formals= []}) bool)

	fun simpleVar (access, level): exp =

	fun unEx(Ex, e) = e
	  | unEx(Nx, g) = ESEQ(s, CONST 0)
	  | unEx(Cx, f) =
	    let val r = Temp.newtemp() (*register*)
	        val l1 = Label.newlabel() (*label*)
	        val l2 = Label.newlabel() (*label*)
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

	fun unCx(Ex, e) =
	  | unCx(Nx, g) =
	  | unCx(Cx, f) = f


	fun transIf(e1, e2, e3)
	    let
	        val i1 = unCx e1
	        val i2 = unEx e2
	        val i3 = unEx e3
	        val t = Label.newlabel()
	        val f = Label.newlabel()
	        val e = Label.newlabel()
	        val r = Label.newlabel()
	    in
	        ESEQ(SEQ [
	                i1(t, f)
	                LABEL t
	                MOVE(TEMP r, i2)
	                JUMP(NAME end, [end])
	                LABEL f
	                MOVE(TEMP r, i3)
	                JUMP(NAME end, [end])
	                ]
	            )
	    end
end

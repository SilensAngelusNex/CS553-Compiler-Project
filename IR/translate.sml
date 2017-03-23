structure Translate: TRANSLATE =
struct

	datatype exp = Ex of Tree.exp
			 | Nx of Tree.stm
			 | Cx of Temp.label * Temp.label -> Tree.stm

	datatype level = L of Frame.frame
					| EMPTY

	type access = level * Frame.access

	val currLevel = ref EMPTY

	fun outermost = currLevel

	fun newLevel {parent: parent, name: name, formals: formals} =  let
																		val n = Frame.newFrame {name: name, formals: true::formals}
																   in
																   		currLevel := L(n);
																		n
																   end
	fun formals L(frame) = case Frame.formals frame of
							a::l => map (fn a => (L(frame), a)) l
						   | _  => []
	  | formals EMPTY = []

	fun allocLocal L(frame) bool = (!currLevel, Frame.allocLocal frame bool)
	  | allocLocal EMPTY bool = (!currLevel, Frame.allocLocal (Frame.newFrame {name= Temp.newLabel (), formals= []}) bool)

end

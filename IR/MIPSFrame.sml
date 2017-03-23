structure MIPSFrame :> FRAME =
struct
	datatype frame = F of Temp.label * access list ref * int ref
	datatype access = InFrame of int
					| InReg of Temp.temp

	fun allocLocals f (i, b::l) = case i < 4 of
									true	=> (putInReg f		; allocLocals f (i + 1, l))
								  | false 	=> (allocLocal f b	; allocLocals f (i + 1, l))

	  | allocLocals f (i, [])   = f

	fun newFrame {name: name, formals: blist} = let
													val f = F (name, [], 0, !currFrame)
													val result = allocLocals f (0, blist)
												in
													currFrame := ref result;
													result
												end

	fun formals F( _, a, _, _) = a

	fun putInReg F(name, alist, size, prev) = 	let
													val result = InReg(Temp.newTemp ())
												in
													alist := !alist@[result];
													result
												end

	fun allocLocal F(name, alist, size, prev) true  = let
														  val result = InFrame(!size * 4)
													  in
													      alist := !alist@[result];
														  size := !size + 1;
														  result
													  end

	  | allocLocal f false = putInReg f
end

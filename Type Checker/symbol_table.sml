structure SymbolTable :> SymbolTableSig =
struct

	type symbol = string
	fun symbol s = s
	fun name s = s

	(* Things to nodes *)
	structure StackMap = SplayMapFn(struct type ord_key = string val compare = String.compare end)
	datatype 'a node = NODE of 'a * symbol * int * 'a node option * 'a node option
	datatype 'a linkedList =  LIST of 'a node option * 'a node option * 'a linkedList option
	(*
	type 'a linkedList = {head: 'a node option, tail: 'a node option, below: 'a linkedList option}
	*)


	type 'a table = 'a node StackMap.map * 'a linkedList * int ref
	fun empty () = (StackMap.empty, LIST(NONE, NONE, NONE), ref 0)



	fun enter ((ns, LIST(listHead, tail, below), i), s, a) = let
																val newNode =
																let
																	val stackHead = StackMap.find (ns, s)
																in
																	i := !i + 1;
																	NODE (a, s, !i, stackHead, listHead)
																end
															in
															(StackMap.insert (ns, s, newNode), LIST(SOME(newNode), tail, below), i)
															end

	fun look ((ns, ls, i), s) = case StackMap.find (ns, s) of
									 SOME(NODE(a, _, _, _, _)) => SOME(a)
								   | NONE => NONE


	fun pop (ns, s) = case StackMap.find (ns, s) of
					       SOME(NODE(_, _, _, SOME(below), _)) => StackMap.insert (ns, s, below)
						 | SOME(NODE(_, _, _, NONE, _)) => (case StackMap.remove (ns, s) of (a, _) => a)
						 | NONE => ns

	fun PopAll (ns, SOME(NODE(_, s, _, _, next))) =  PopAll(pop (ns, s), next)
	  | PopAll (ns, NONE) = ns


	fun leaveScope (ns, LIST(listHead, tail, below), i) = case below of
													  SOME(list) => (PopAll (ns, listHead), list, i)
													 | NONE => (PopAll (ns, listHead), LIST(NONE, NONE, NONE), i)


	fun beginScope (ns, ls, i) = (ns, LIST(NONE, NONE, SOME(ls)), i)

end

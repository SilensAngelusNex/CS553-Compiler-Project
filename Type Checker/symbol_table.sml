structure Symbol :> SymbolSig =
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


	datatype 'a table = TABLE of 'a node StackMap.map * 'a linkedList * int ref
					  | EMPTY


	val empty = EMPTY



	fun enter (TABLE(ns, LIST(listHead, tail, below), i), s, a) = let
																val newNode =
																let
																	val stackHead = StackMap.find (ns, s)
																in
																	i := !i + 1;
																	NODE (a, s, !i, stackHead, listHead)
																end
															in
															TABLE(StackMap.insert (ns, s, newNode), LIST(SOME(newNode), tail, below), i)
															end
	 | enter (EMPTY, s, a) = enter (TABLE(StackMap.empty, LIST(NONE, NONE, NONE), ref 0), s, a)


	fun look (TABLE(ns, ls, i), s) = (case StackMap.find (ns, s) of
									 SOME(NODE(a, _, _, _, _)) => SOME(a)
								   | NONE => NONE)
	  | look (EMPTY, s) = NONE


	fun pop (ns, s) = (case StackMap.find (ns, s) of
					       SOME(NODE(_, _, _, SOME(below), _)) => StackMap.insert (ns, s, below)
						 | SOME(NODE(_, _, _, NONE, _)) => (case StackMap.remove (ns, s) of (a, _) => a)
						 | NONE => ns)

	fun PopAll (ns, SOME(NODE(_, s, _, _, next))) =  PopAll(pop (ns, s), next)
	  | PopAll (ns, NONE) = ns


	fun leaveScope (TABLE(ns, LIST(listHead, tail, below), i)) = (case below of
													  SOME(list) => TABLE(PopAll (ns, listHead), list, i)
													 | NONE => TABLE(PopAll (ns, listHead), LIST(NONE, NONE, NONE), i))
	  | leaveScope EMPTY = EMPTY



	fun beginScope (TABLE(ns, ls, i)) = TABLE(ns, LIST(NONE, NONE, SOME(ls)), i)
	| beginScope EMPTY = EMPTY
end

structure SymbolTable =
struct
	structure StackMap = SplayMapFn(struct type ord_key = string val compare = String.compare end)
	structure StartMap = SplayMapFn(struct type ord_key = int val compare = Int.compare end)
	datatype node = NODE of Types.ty * node ref * node ref
	type linkedList = {head: node ref, tail: node ref}

	type symbol = string
	fun symbol s = s
	fun name s = s

	type table = node StackMap.map * linkedList StartMap.map * int
	fun empty () = (StackMap.empty, StartMap.empty, 0)
	fun enter (t, s, ty) = t
	fun look (t, s) = t

	fun beginScope table = table
	fun leaveScope  table = table
end

fun ptest(opt) = case opt of
				SOME(a) => print (Int.toString a)
				| NONE => print "none";
fun test() =
	let val map = SymbolTable.empty()
		val s = SymbolTable.symbol "test"
		val s2 = SymbolTable.symbol "test2"
		val s3 = SymbolTable.symbol "test3"
		val map = SymbolTable.enter (map, s, 1)
		val map = SymbolTable.enter (map, s2, 3)
		val map = SymbolTable.enter (map, s, 2)
		val map = SymbolTable.enter (map, s2, 4)
		val r = SymbolTable.look (map, s)
		val r1 = SymbolTable.look (map, s2)
		(* 24 *)
		val t = ptest(r)
		val t = ptest(r1)
		val p = print "\n"
		val map = SymbolTable.leaveScope(map)
		val r = SymbolTable.look (map, s)
		val r1 = SymbolTable.look (map, s2)
		val t = ptest(r)
		val t = ptest(r1)
		(* nonenone *)
		val p = print "\n"
		val map = SymbolTable.enter (map, s, 1)
		val map = SymbolTable.enter (map, s2, 2)
		val map = SymbolTable.enter (map, s3, 3)
		val map = SymbolTable.beginScope(map)
		val map = SymbolTable.enter (map, s, 7)
		val map = SymbolTable.enter (map, s2, 8)
		val map = SymbolTable.leaveScope(map)
		val r = SymbolTable.look (map, s)
		val r1 = SymbolTable.look (map, s2)
		val r2 = SymbolTable.look (map, s3)
		(* 123 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
		val map = SymbolTable.beginScope(map)
		val r = SymbolTable.look (map, s)
		val r1 = SymbolTable.look (map, s2)
		(* 123 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
		val map = SymbolTable.beginScope(map)
		val map = SymbolTable.beginScope(map)
		val map = SymbolTable.enter (map, s3, 8)
		val r = SymbolTable.look (map, s)
		val r1 = SymbolTable.look (map, s2)
		val r2 = SymbolTable.look (map, s3)
		(* 128 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
		val map = SymbolTable.leaveScope(map)
		val r = SymbolTable.look (map, s)
		val r1 = SymbolTable.look (map, s2)
		val r2 = SymbolTable.look (map, s3)
		(* 123 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
	in
	ptest(r1)
	end

fun ptest(opt) = case opt of
				SOME(a) => print (Int.toString a)
				| NONE => print "none";
fun test() =
	let val map = Symbol.empty()
		val s = Symbol.symbol "test"
		val s2 = Symbol.symbol "test2"
		val s3 = Symbol.symbol "test3"
		val map = Symbol.enter (map, s, 1)
		val map = Symbol.enter (map, s2, 3)
		val map = Symbol.enter (map, s, 2)
		val map = Symbol.enter (map, s2, 4)
		val r = Symbol.look (map, s)
		val r1 = Symbol.look (map, s2)
		(* 24 *)
		val t = ptest(r)
		val t = ptest(r1)
		val p = print "\n"
		val map = Symbol.leaveScope(map)
		val r = Symbol.look (map, s)
		val r1 = Symbol.look (map, s2)
		val t = ptest(r)
		val t = ptest(r1)
		(* nonenone *)
		val p = print "\n"
		val map = Symbol.enter (map, s, 1)
		val map = Symbol.enter (map, s2, 2)
		val map = Symbol.enter (map, s3, 3)
		val map = Symbol.beginScope(map)
		val map = Symbol.enter (map, s, 7)
		val map = Symbol.enter (map, s2, 8)
		val map = Symbol.leaveScope(map)
		val r = Symbol.look (map, s)
		val r1 = Symbol.look (map, s2)
		val r2 = Symbol.look (map, s3)
		(* 123 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
		val map = Symbol.beginScope(map)
		val r = Symbol.look (map, s)
		val r1 = Symbol.look (map, s2)
		(* 123 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
		val map = Symbol.beginScope(map)
		val map = Symbol.beginScope(map)
		val map = Symbol.enter (map, s3, 8)
		val r = Symbol.look (map, s)
		val r1 = Symbol.look (map, s2)
		val r2 = Symbol.look (map, s3)
		(* 128 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
		val map = Symbol.leaveScope(map)
		val r = Symbol.look (map, s)
		val r1 = Symbol.look (map, s2)
		val r2 = Symbol.look (map, s3)
		(* 123 *)
		val t = ptest(r)
		val t = ptest(r1)
		val t = ptest(r2)
		val p = print "\n"
	in
	ptest(r1)
	end

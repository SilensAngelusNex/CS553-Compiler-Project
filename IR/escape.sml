structure FindEscape: sig
						val findEscape: Absyn.exp -> unit
					  end
struct
	type depth = int
	type escEnv = (depth * bool ref) Symbol.table


	fun addArgs (env, d, {name=n, escape=e, typ=_, pos=_}::p) = addArgs (Symbol.enter (env, n, (d, e)), d, p)
	  | addArgs (env, _, []) = env

	fun traverseFundec (env, depth) {name=_, params=p, result=_, body=e, pos=_} = let
																					val depth = depth + 1
																					val env = Symbol.beginScope env
																					val env = addArgs (env, d, p)
																				  in
																				  	traverseExp (env, d, e)
																				  end

	fun traverseVar (env, d, SimpleVar(s, pos)) =
	  | traverseVar (env, d, FieldVar(s, pos)) =
	  | traverseVar (env, d, SubscriptVar(v, e, pos)) =

	and traverseExp (env, d, VarExp(v)) = case Symbol.look (env, n) of
											SOME (depth, b) => 	(if depth > d
																then b := true)
											| NONE => ()
	  | traverseExp (env, d, CallExp {func=s, args=elist, pos=pos}) = foldl (fn (e, ()) => traverseExp(env, d, e)) () elist
	  | traverseExp (env, d, OpExp {left=lexp, oper=_, right=rexp, pos=_}) = (traverseExp(env, d, lexp); traverseExp(env, d, rexp))
	  | traverseExp (env, d, SeqExp(expList)) = foldl (fn ((e, p), ()) => traverseExp(env, d, e)) () expList
	  | traverseExp (env, d, AssignExp {var=_, exp=e, pos=_}) = traverseExp(env, d, e)
	  | traverseExp (env, d, RecordExp {fields=flist, typ=_, pos=_}) = foldl (fn ((_, e,_), ()) => traverseExp(env, d, e)) () flist
	  | traverseExp (env, d, IfExp {test=e1, then'=e2, else'=SOME(e3), pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2); traverseExp(env, d, e3))
	  | traverseExp (env, d, IfExp {test=e1, then'=e2, else'=NONE, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2))
	  | traverseExp (env, d, WhileExp {test=e1, body=e2, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2))
	  | traverseExp (env, d, ForExp {var=n, escape=e, lo=e1, hi=e2, body=e3, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2); traverseExp(Symbol.enter (env, n, (d, e)), d, e3))
	  | traverseExp (env, d, LetExp {decs=decs, body=e, pos=_}) = let
	  																val d = d+1
	  																val env = foldl (fn (dec, newEnv) => traverseDec (newEnv, d, dec)) (Symbol.beginScope env) decs
	  															  in
																  	traverseExp (env, d, e)
																  end
	  | traverseExp (env, d, ArrayExp {typ=_, size=e1 init=e2, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2))


	and traverseDec (env, d, VarDec {name=n, escape=e, typ:_, init=e, pos=pos}) = (tranverseExp (env, d, e); e := false; Symbol.enter (env, n, (d, e)))
	  | traverseDec (env, d, FunctionDec(flist) = (foldl (traverseFundec (env, d)) () flist; env)
	  | traverseDec (env, _, _) = env

	fun findEscape prog = traverseExp (Symbol.beginScope Symbol.empty, 0, prog)
end

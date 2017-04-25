structure FindEscape: sig
						val findEscape: Absyn.exp -> unit
					  end =
struct
	structure A = Absyn
	type depth = int
	type escEnv = (depth * bool ref) Symbol.table


	fun addArgs (env, d, {name=n, escape=e, typ=_, pos=_}::p) = (e := false; addArgs (Symbol.enter (env, n, (d, e)), d, p))
	  | addArgs (env, _, []) = env


	fun traverseVar (env, d, A.SimpleVar(n, pos)) =  (case Symbol.look (env, n) of
													SOME (depth, b) => 	(if depth > d
																		then b := true
																		else ())
													| NONE => ())
	  | traverseVar (env, d, A.FieldVar(v, n, pos)) = traverseVar (env, d, v)
	  | traverseVar (env, d, A.SubscriptVar(v, e, pos)) = (traverseExp (env, d, e); traverseVar (env, d, v))

	and traverseExp (env, d, A.VarExp(v)) = traverseVar (env, d, v)
	  | traverseExp (env, d, A.CallExp {func=s, args=elist, pos=pos}) = foldl (fn (e, ()) => traverseExp(env, d, e)) () elist
	  | traverseExp (env, d, A.OpExp {left=lexp, oper=_, right=rexp, pos=_}) = (traverseExp(env, d, lexp); traverseExp(env, d, rexp))
	  | traverseExp (env, d, A.SeqExp(expList)) = foldl (fn ((e, p), ()) => traverseExp(env, d, e)) () expList
	  | traverseExp (env, d, A.AssignExp {var=_, exp=e, pos=_}) = traverseExp(env, d, e)
	  | traverseExp (env, d, A.RecordExp {fields=flist, typ=_, pos=_}) = foldl (fn ((_, e,_), ()) => traverseExp(env, d, e)) () flist
	  | traverseExp (env, d, A.IfExp {test=e1, then'=e2, else'=SOME(e3), pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2); traverseExp(env, d, e3))
	  | traverseExp (env, d, A.IfExp {test=e1, then'=e2, else'=NONE, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2))
	  | traverseExp (env, d, A.WhileExp {test=e1, body=e2, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2))
	  | traverseExp (env, d, A.ForExp {var=n, escape=e, lo=e1, hi=e2, body=e3, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2); traverseExp(Symbol.enter (env, n, (d, e)), d, e3))
	  | traverseExp (env, d, A.LetExp {decs=decs, body=e, pos=_}) = let
	  																val env = foldl (fn (dec, newEnv) => traverseDec (newEnv, d, dec)) env decs
	  															  in
																  	traverseExp (env, d, e)
																  end
	  | traverseExp (env, d, A.ArrayExp {typ=_, size=e1, init=e2, pos=_}) = (traverseExp(env, d, e1); traverseExp(env, d, e2))
	  | traverseExp (env, d, _) = ()


	and traverseDec (env, d, A.VarDec {name=n, escape=e, typ=_, init=exp, pos=pos}) = (traverseExp (env, d, exp); e := false; Symbol.enter (env, n, (d, e)))
	  | traverseDec (env, d, A.FunctionDec(flist)) = (foldl (traverseFundec (env, d)) () flist; env)
	  | traverseDec (env, _, _) = env

  and traverseFundec (env, depth) ({name=_, params=p, result=_, body=e, pos=_}, ()) = let
																				  val d = depth + 1
																				  val env = Symbol.beginScope env
																				  val env = addArgs (env, d, p)
																				in
																				  traverseExp (env, d, e)
																				end

	fun findEscape prog = traverseExp (Symbol.beginScope Symbol.empty, 0, prog)
end

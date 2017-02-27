structure Semant : SemantSig =
struct
	structure SymbolTable
	structure A = Absyn

	type venv  = ENV.enventry Symbol.table
	type tenv  = ty Symbol.table
	type expty = {exp: Translate.exp, ty: Types.ty}

	val transVar = venv * tenv * Absyn.var -> expty

	fun transExp (venv, tenv) = (*venv * tenv * Absyn.var -> expty*)
	 	let
			fun trexp (A.OpExp{left, oper=A.PlusOp, right, pos}) =
						(checkInt(trexp left, pos);
				 		checkInt(trexp right, pos);
				 		{exp=(), ty=Types.INT})
			  	| trexp(A.LetExp{decs, body, pos}) =
					let
						val {venv=new_venv, tenv=new_tenv} = transDecs(venv, tenv, decs)
					in
						transExp(new_venv, new_tenv) body
					end
			  	| trexp(VarExp(var)) = trvar(var)
		 		| trexp(NilExp) = {exp=(), ty=Types.NIL}
		 	    | trexp(IntExp(int)) = {exp=(), ty=Types.INT}
				| trexp(StringExp(string, pos)) = {exp=(), ty=Types.STRING}
				(*| trexp(CallExp{func: symbol, args: exp list, pos: pos}) =
				| trexp(A.RecordExp{fields: (symbol * exp * pos) list, typ: symbol, pos: pos}) =
				| trexp(SeqExp(exp_pos_list))=
	        	| trexp(AssignExp{var: var, exp: exp, pos: pos}) =
				| trexp(A.WhileExp{test: exp, body: exp, pos: pos}) =
				| trexp(A.IfExp{test: exp, then': exp, else': exp option, pos: pos}) =
				| trexp(A.WhileExp{test: exp, body: exp, pos: pos}) =
				| trexp(A.ForExp{var: symbol, escape: bool ref, lo: exp, hi: exp, body: exp, pos: pos}) =
				| trexp(A.BreakExp(pos)) =

	        	| trexp(A.ArrayExp{typ: symbol, size: exp, init: exp, pos: pos}) =
				*)

			and trvar (A.SimpleVar(id, pos)) =
				(case SymbolTable.look(venv, id) of
					SOME(E.VarEntry {ty}) => {exp=(), ty=actual_ty ty}
				  | NONE => (error pos ("undefined variable " ^ S.name id);
				  			exp=(), ty=Types.INT))
				(*
				| trvar (A.FieldVar(v, id, pos)) =
				| trvar(SubscriptVar(var, exp, pos)) =
				*)
		in
		trexp
		end


	fun transDecs (venv, tenv, decs) = foldl
										(fn ({venv: venv, tenv: tenv}, d) => transDec (venv, tenv, d))
										{venv: venv, tenv: tenv}
										decs;


	val transDec = venv * tenv * Absyn.dec -> {venv: venv, tenv: tenv}
	val transTy  =        tenv * Absyn.ty -> Types.ty

	val transProg : Absyn.exp -> unit


	fun checkInt ({exp, ty}, pos ) = (...)
end

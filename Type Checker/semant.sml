structure Semant :> SemantSig =
struct
	structure SymbolTable
	structure A = Absyn

	type venv  = ENV.enventry Symbol.table
	type tenv  = ty Symbol.table
	type expty = {exp: Translate.exp, ty: Types.ty}

	(*								*
  	 * 	API							*
  	 *  							*)

	fun transProg exp: unit = ()


	(*									*
	 * 	Private Translation Functions	*
	 *  								*)

	fun transExp (venv, tenv) =
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
				  | NONE => (error pos ("undefined variable " ^ S.name id); {exp=(), ty=Types.INT}))
				| trvar (A.FieldVar(v, id, pos)) 	 = {exp=(), ty=Types.INT}
				| trvar(SubscriptVar(var, exp, pos)) = {exp=(), ty=Types.INT}
		in
		trexp
		end

	fun transVar (A.SimpleVar(id, pos)) 		= {exp=(), ty=(lookUpSymbol id)}
	   | transVar (A.FieldVar(v, id, pos)) 		= {exp=(), ty=(lookUpSymbol id)}
	   | transVar(SubscriptVar(var, exp, pos)) 	= {exp=(), ty=Types.INT}

	fun transDecs (venv, tenv, decs) = foldl updateEnvWithDec {venv: venv, tenv: tenv} decs;

    fun transDec (venv, tenv, FunctionDec(lst)) = {venv: venv, tenv: tenv}
	   | transDec (venv, tenv, TypeDec(lst)) = {venv: venv, tenv: tenv}
	   | transDec (venv, tenv, VarDec({symName, escape, typ, init, pos})) = {venv: venv, tenv: tenv}

	fun transTy (tenv, NameTy(symbol, pos)) 	= Types.Name(symbol, nil)
	  | transTy (tenv, ArrayTy(symbol, pos)) 	= Types.Array((lookUpSymbol symbol), int ref)
	  | transTy (tenv, RecordTy(fields)) 		= Types.Record((convertFields fields), int ref)

	(*								*
	 * 	Private Helper Functions	*
	 *  							*)


	(* Converts fields to (Symbol.symbol * ty) list *)
	fun convertFields fields: (Symbol.symbol * ty) list = map convertField fields

	fun convertField {name, escape, typ, pos} = (name, (retrieveSymbolType name) )

    (* Wrapper for transDec 											*
 	 * {venv: venv, tenv: tenv} * Absyn.Dec -> {venv: venv, tenv: tenv}	*)
 	fun updateEnvWithDec ({venv: venv, tenv: tenv}, d) = transDec (venv, tenv, d)

	fun checkInt ({exp, ty}, pos ) = ()

	fun lookUpSymbol symbol: Types.ty = case SymbolTable.look(venv, symbol) of
										   		SOME(E.VarEntry {ty}) 	=> lookUpActualSymType ty
										   	  | NONE 					=> (error pos ("undefined variable " ^ S.name id); Types.INT})

	(* Retrieves actual type form Type.NAME  *)
	fun lookUpActualSymType NAME(sym, tyOpt) = case tyOpt of
												  SOME(ty) 	=> ty
												| NONE		=> (error pos ("undefined variable " ^ S.name id); Types.INT})
	  | lookUpActualSymType ty = ty

end

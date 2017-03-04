structure Semant :> SemantSig =
struct
	structure A = Absyn
	structure M = SplayMapFn(struct type ord_key = string val compare = String.compare end)
	type venv  = ENV.enventry Symbol.table
	type tenv  = Types.ty Symbol.table
	type expty = {exp: Translate.exp, ty: Types.ty}

    (*								*
	 * 	Private Helper Functions	*
	 *  							*)

	(* Converts fields to (Symbol.symbol * ty) list *)

	(* Retrieves actual type from Type.NAME  *)
	fun lookUpActualSymType (Types.NAME(sym, tyOpt)): Types.ty = (case !tyOpt of
												  						SOME(ty) => ty
												  		  			  | NONE	 => Types.INT) (* throw error *)
	 	| lookUpActualSymType ty: Types.ty = ty;


	fun lookUpSymbol (venv, symbol, pos): Types.ty = case Symbol.look(venv, symbol) of
													   		SOME(ENV.VarEntry {ty})						=> (lookUpActualSymType ty)
														  | SOME(ENV.FunEntry {formals=f,result=ty})	=> (lookUpActualSymType ty)
													   	  | NONE										=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); Types.INT)

	fun lookUpSymbolTENV (tenv, symbol, pos): Types.ty option = (case Symbol.look(tenv, symbol) of
												   		  	 		SOME(ty)	=> SOME(lookUpActualSymType ty)
												   	  		  		| NONE		=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); NONE))

	fun lookUpSymbolOpt (venv, SOME(sym, pos)): Types.ty = lookUpSymbol	(venv, sym, pos)
	  | lookUpSymbolOpt (venv, NONE): Types.ty = (ErrorMsg.error 0 ("undefined variable"); Types.INT)

	fun convertRecordField (tenv, {name, escape, typ, pos}): (Symbol.symbol * Types.ty) = case Symbol.look (tenv, name) of
																							SOME(ty) => (name, ty)
																						  | NONE => (name, Types.UNIT)

	fun convertRecordFields (tenv, fields): (Symbol.symbol * Types.ty) list = map (fn (f) => convertRecordField (tenv, f)) fields;

	fun checkInt ({exp=exp, ty=Types.INT}, pos ) = ()
	  | checkInt (_, pos) = (ErrorMsg.error pos ("Expected INT Found: " ^ "other"))

	fun compare (x, y) = x = y

	fun checkIntPair (left, right, pos) =
		(checkInt(left, pos);
		checkInt(right, pos);
		{exp=(), ty=Types.INT})


	fun sameTypes (ty1, ty2, pos) =  case (ty1 = ty2) of
									  true  => ({exp=(), ty=ty1})
									| false => ((ErrorMsg.error pos ("Types not the same: " ^ "other and " ^ "other"));
												{exp=(), ty=Types.INT})

	fun checkPair ({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = (sameTypes (ty1, ty2, pos))

	fun getType ({exp=exp, ty=ty}): Types.ty = ty

	fun checkDuplicateFunctionField (m, name, pos) = case M.find (m, Symbol.name name) of
													SOME(_) => (ErrorMsg.error pos ("Duplicate function field " ^ Symbol.name name))
												  | NONE => ();

	fun transparam ({name=name,typ=typ,pos=pos,escape=_}, tenv, (l, m)) = (	checkDuplicateFunctionField(m, name, pos);
																	   	M.insert (m, Symbol.name name, true);
																	   	case lookUpSymbolTENV (tenv, typ, pos) of
																			SOME t => ({name=name, ty=t}::l, M.insert (m, Symbol.name name, true))
																		   | NONE  => ({name=name, ty=Types.UNIT}::l, M.insert (m, Symbol.name name, true)));
	(*									*
	 * 	Private Translation Functions	*
	 *  								*)

	fun transVar (venv, A.SimpleVar(id, pos)) 			= {exp=(), ty=(lookUpSymbol (venv, id, pos))}
 	  | transVar (venv, A.FieldVar(v, id, pos)) 		= {exp=(), ty=(lookUpSymbol (venv, id, pos))}
 	  | transVar (venv, A.SubscriptVar(var, exp, pos)) 	= {exp=(), ty=Types.INT}

 	fun transTy (tenv, A.NameTy(symbol, pos)) 	= (case lookUpSymbolTENV (tenv, symbol, pos) of
													SOME(ty) => ty
													| NONE => (ErrorMsg.error pos ("Unrecognized symbol: " ^ (Symbol.name symbol)); Types.UNIT))
 	  | transTy (tenv, A.ArrayTy(symbol, pos)) 	= (case lookUpSymbolTENV (tenv, symbol, pos) of
	  												SOME(ty) => Types.ARRAY(ty, ref ())
												  | NONE => Types.ARRAY(Types.UNIT, ref ()))
 	  | transTy (tenv, A.RecordTy(fields)) 		= Types.RECORD((convertRecordFields (tenv, fields)), ref ())

	(*recursive types*)
  	fun processTypeHeaders ({name, ty, pos}, tenv) = Symbol.enter (tenv, name, Types.NAME(name, ref NONE))

  	fun processTypeBodies ({name, ty, pos}, tenv) = case Symbol.look (tenv, name) of
  												  SOME(Types.NAME(name, r)) => (r := SOME(transTy (tenv, ty)); tenv)
  												| SOME(_) => (ErrorMsg.error pos ("Unexpected Type for symbol: " ^ (Symbol.name name)); tenv)
  												| NONE => (ErrorMsg.error pos ("Unrecognized symbol: " ^ (Symbol.name name)); tenv)

	fun transExp (venv, tenv) =
		let
			fun trexp (A.OpExp{left, oper=A.PlusOp, right, pos})   	= checkIntPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.MinusOp, right, pos})  	= checkIntPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.TimesOp, right, pos})  	= checkIntPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.DivideOp, right, pos}) 	= checkIntPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.EqOp, right, pos}) 	   	= checkPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.NeqOp, right, pos})  	= checkPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.LtOp, right, pos})  	= checkPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.LeOp, right, pos}) 		= checkPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.GtOp, right, pos}) 		= checkPair (trexp left, trexp right, pos)
			  | trexp (A.OpExp{left, oper=A.GeOp, right, pos}) 		= checkPair (trexp left, trexp right, pos)
			  | trexp(A.VarExp(var)) 								= trvar(var)
			  | trexp(A.NilExp) 									= {exp=(), ty=Types.NIL}
			  | trexp(A.IntExp(int)) 								= {exp=(), ty=Types.INT}
			  | trexp(A.StringExp(string, pos)) 					= {exp=(), ty=Types.STRING}
			  | trexp(A.SeqExp((exp, pos)::seq)) 					= (trexp exp; trseq seq)
			  | trexp(A.LetExp{decs, body, pos}) =
												  let
												  	val (venv, tenv) = (Symbol.beginScope venv, Symbol.beginScope tenv)
												  	val {venv=new_venv, tenv=new_tenv} = transDecs(venv, tenv, decs)
												  in
												  	transExp(new_venv, new_tenv) body
												  end

				| trexp(A.CallExp{func, args, pos}) = (case Symbol.look(venv, func) of
														 SOME(ENV.FunEntry{formals=paramTys, result=ty}) => (paramList (paramTys, args, pos); {exp=(), ty=lookUpActualSymType ty}) (* CHECK ALL PARAMETERS*)
														| SOME(ENV.VarEntry{ty=ty}) => (ErrorMsg.error pos ("Symbol is not a function: " ^ (Symbol.name func)); {exp=(), ty=Types.INT})
														| NONE => (ErrorMsg.error pos ("Unrecognized function  " ^ (Symbol.name func)); {exp=(), ty=Types.INT}))
				| trexp(A.AssignExp{var, exp, pos}) = checkPair(trvar var, trexp exp, pos)
				| trexp(A.WhileExp{test, body, pos}) =  let
														val testTy = trexp test
														val bodyTy = trexp body
														in
														(print "while" ; checkInt(testTy, pos); bodyTy)
														end

				| trexp(A.IfExp{test=test,then'=thenExp,else'=SOME(elseExp),pos=pos}) = let
																						val testTy = trexp test
																						val thenTy = trexp thenExp
																						val elseTy = trexp elseExp
																						in
																						(print "if" ; checkInt(testTy, pos); checkPair (thenTy, elseTy, pos))
																						end


				| trexp(A.IfExp{test=test,then'=thenExp,else'=NONE,pos=pos}) =  let
																				val testTy = trexp test
																				val thenTy = trexp thenExp
																				in
																				(print "if2" ; checkInt(testTy, pos); thenTy)
																				end
				| trexp(A.ArrayExp{typ, size, init, pos}) = 	let
																val typ = lookUpSymbolTENV (tenv, typ, pos)
																val sizeExp = trexp size
																val initExp = trexp init
																in
																case typ of
																     SOME(Types.ARRAY(aType, aRef)) =>
																	 		(print "array" ;
																	   		checkInt(sizeExp, pos);
																			sameTypes(aType, getType initExp, pos);
																  			{exp=(), ty=Types.ARRAY(aType, aRef)})
																   | SOME(_) => ((ErrorMsg.error pos ("Tried to construct an array non array type. ")); {exp=(), ty=Types.INT})
																   | NONE => ((ErrorMsg.error pos ("Array type not declared."));
																   				{exp=(), ty=Types.ARRAY(Types.INT, ref ())})
																end
				| trexp(A.RecordExp{fields, typ, pos}) = 	let
																val typ = lookUpSymbolTENV (tenv, typ, pos)
																val recRef = case typ of SOME(Types.RECORD (_, r)) => r | _ => ((ErrorMsg.error pos ("Array type not declared.")); ref ())
															in
															{exp=(), ty=Types.RECORD((map recList fields), recRef)}
															end

				| trexp(A.ForExp{var=symbol,escape=escape,
								lo=lo,hi=hi,body=body,pos=pos}) = 	let
																	val (venv, tenv) = (Symbol.beginScope (venv), Symbol.beginScope (tenv))
																	val loTy = trexp lo
																	val hiTy = trexp hi
																	val tenv = Symbol.enter (tenv, symbol, Types.INT)
																	in
																	(print "for" ; checkInt(loTy, pos);
																	 checkInt(hiTy, pos);
																	 transExp (venv, tenv) body)
																	end

				| trexp(A.BreakExp(pos)) = {exp=(), ty=Types.UNIT}
				| trexp(l) = (print "other type of expression" ; {exp=(), ty=Types.UNIT})

			and trvar (A.SimpleVar(id, pos)) 			= {exp=(), ty=lookUpSymbol (venv, id, pos)}
				| trvar (A.FieldVar(v, id, pos)) 	    = {exp=(), ty=Types.INT}
				| trvar (A.SubscriptVar(var, exp, pos)) = {exp=(), ty=Types.INT}

			and trseq ((exp, pos)::nil) = trexp exp
			  | trseq ((exp, pos)::seq) = (trexp exp; trseq seq)
			  | trseq (nil)  			= {exp=(), ty=Types.UNIT}

			and paramList (t::typeList, a::argList, pos) = let
														val {exp=aExp, ty=aTy} = trexp a
													in
														if (t = aTy)
														then paramList (typeList, argList, pos)
														else ((ErrorMsg.error pos ("Argument Type Incorrect: " ^ "other and " ^ "other")); false)
													end
			  | paramList ([], [], pos) = true
			  | paramList ([], a::argList, pos) = ((ErrorMsg.error pos ("Too many arguments for function!")); false)
			  | paramList (t::typeList, [], pos) = ((ErrorMsg.error pos ("Not enough arguments for function!")); false)

			and recList (field, exp, pos): (Symbol.symbol * Types.ty) = case lookUpSymbolTENV (tenv, field, pos) of
																		SOME(ty) => (field, ty)
																		| NONE => (ErrorMsg.error pos ("Record Arg do not match expected type"); (field, Types.UNIT))

		in
		trexp
		end

		and transDec (A.FunctionDec(lst), {venv, tenv})	= 	let
														  		val (venv', tenv') = (foldl processFunctionHeaders (venv, tenv) lst)
															  	val (venv'', tenv'') = (foldl processFunctionBodies (venv', tenv) lst)
														  	in
															  	{venv=venv'', tenv=tenv}
															end

		  | transDec (A.TypeDec(lst), {venv, tenv}) = let
														val tenv' = (foldl processTypeHeaders tenv lst)
														val tenv'' = (foldl processTypeBodies tenv' lst)
													  in
													  	{venv=venv, tenv=tenv''}
													  end
		  | transDec (A.VarDec({name=name,escape=escape,typ=NONE, init=init, pos=pos}),
		  						{venv, tenv}) = let
												val {exp, ty} = transExp(venv, tenv) init
												in
												{venv=Symbol.enter(venv, name, ENV.VarEntry{ty=ty}), tenv=tenv}
												end
		  | transDec (A.VarDec({name=name, escape=x, typ=SOME(sym, p), init=init, pos=pos}),
		  						{venv, tenv}) = let
												val typ = case lookUpSymbolTENV (tenv, sym, pos) of SOME(ty) => ty | NONE => Types.INT
												val {exp=exp,ty=expTy} = transExp (venv, tenv) init
				  								val entry = ENV.VarEntry({ty=typ})
				  							  	val venv = Symbol.enter (venv, name, entry)
				  							  	in
												case expTy of
													Types.NIL => (case typ of Types.RECORD(_, _) => {venv=venv, tenv=tenv} | _ => (ErrorMsg.error pos ("Nil can only be assigned to records."); {venv=venv, tenv=tenv}))
													| _ => (compare (typ, expTy); {venv=venv, tenv=tenv})
				  							  	end


		and transDecs (venv, tenv, decs) = (foldl transDec {venv=venv, tenv=tenv} decs)

		and processFunctionHeaders ({name=name,params=params,result=SOME((sym, rpos)),body=body,pos=pos}, (venv, tenv)) = 	let
																															val x = Int.toString pos
																															val (params', m) = foldl (fn (p,acc) => transparam(p, tenv, acc)) ([], M.empty) params
																															val symTy = case lookUpSymbolTENV (tenv, sym, rpos) of
																																			SOME(ty) => ty
																																		  | NONE => Types.UNIT
																															val fnDec = ENV.FunEntry({formals=map #ty params', result=symTy})
																															val venv' = Symbol.enter (venv, name, fnDec)
																														in
																															(venv', tenv)
																														end
		| processFunctionHeaders ({name=name,params=params,result=NONE,body=body,pos=pos}, (venv, tenv)) = 	let
																											val x = Int.toString pos
																											val (params', m) = foldl (fn (p,acc) => transparam(p, tenv, acc)) ([], M.empty) params
																											val symTy = Types.NAME (name, ref NONE)
																											val fnDec = ENV.FunEntry({formals=map #ty params', result=symTy})
																											val venv' = Symbol.enter (venv, name, fnDec)
																										in
																											(venv', tenv)
																										end

		and processFunctionBodies ({name, params, result=result, body, pos}, (venv, tenv)) = case Symbol.look(venv, name) of
																									NONE => (venv, tenv)
																							   	  | SOME(ENV.VarEntry {ty})						=> (venv, tenv)
																								  | SOME(ENV.FunEntry {formals=f,result=ty})	=> case ty of
																								  													Types.NAME(sym, r) => let
																																										val {exp=exp, ty=bodyTy} = transExp (venv, tenv) body
																																									in
																																										(r := SOME(bodyTy); (venv, tenv))
																																									end

																																					| _ => (venv, tenv)

(*								*
	* 	API							*
	*  								*)

	fun transProg exp = let val x = transExp (ENV.base_venv, ENV.base_tenv) exp in () end

end

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
	 val uniq = ref 0
	 fun unique () = (uniq := !uniq + 1; !uniq)

	 fun typeToString (Types.RECORD (n, _)) = "RECORD"
		 | typeToString (Types.NIL) = "Nil"
		 | typeToString (Types.INT) = "Int"
		 | typeToString (Types.STRING) = "String"
		 | typeToString (Types.ARRAY (t, _)) = "Array of type: " ^ (typeToString t)
		 | typeToString (Types.NAME (n, _)) = "Name: " ^ Symbol.name n
		 | typeToString (Types.UNIT)  = "UNIT"
		 | typeToString (Types.UNDEFINED)  = "Undefined"

	 fun isSubtype (Types.UNIT, _, pos) = true
	 	| isSubtype (Types.RECORD(_,_), Types.NIL, pos) = true
		| isSubtype (Types.RECORD(_,r), Types.RECORD(_,r2), pos) = r = r2
		| isSubtype (Types.ARRAY(_,r), Types.ARRAY(_,r2), pos) = r = r2
		| isSubtype (Types.NAME(s,_), Types.NAME(s2,_), pos) = s = s2
		| isSubtype (_, Types.UNDEFINED, pos) = true
		| isSubtype (a, b, pos) = if a = b then true else false

	(* Converts fields to (Symbol.symbol * ty) list *)

	(* Retrieves actual type from Type.NAME  *)
	fun lookUpActualSymType (Types.NAME(sym, tyOpt), pos): Types.ty = (case !tyOpt of
												  						SOME(ty) => ty
												  		  			  | NONE	 => (ErrorMsg.error pos ("undefined variable " ^ Symbol.name sym); Types.UNDEFINED))
	 	| lookUpActualSymType (ty, pos): Types.ty = ty;


	fun lookUpSymbol (venv, symbol, pos): Types.ty = case Symbol.look(venv, symbol) of
													   		SOME(ENV.VarEntry {ty})						=> (lookUpActualSymType (ty, pos))
														  | SOME(ENV.FunEntry {formals=f,result=ty})	=> (lookUpActualSymType (ty, pos))
													   	  | NONE										=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); Types.INT)

	fun lookUpSymbolTENV (tenv, symbol, pos): Types.ty option = (case Symbol.look(tenv, symbol) of
												   		  	 		SOME(ty)	=> SOME(lookUpActualSymType (ty, pos))
												   	  		  		| NONE		=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); NONE))

	fun lookUpSymbolOpt (venv, SOME(sym, pos)): Types.ty = lookUpSymbol	(venv, sym, pos)
	  | lookUpSymbolOpt (venv, NONE): Types.ty = (ErrorMsg.error 0 ("undefined variable"); Types.UNDEFINED)

	fun convertRecordField (tenv, {name, escape, typ, pos}): (Symbol.symbol * Types.ty) = case Symbol.look (tenv, typ) of
																							SOME(ty) => (name, ty)
																						  | NONE => (ErrorMsg.error pos ("Type " ^ (Symbol.name typ) ^ "not defined."); (name, Types.UNIT))

	fun convertRecordFields (tenv, fields): (Symbol.symbol * Types.ty) list = map (fn (f) => convertRecordField (tenv, f)) fields;

	fun checkInt ({exp=exp, ty=Types.INT}, pos ) = ()
	  | checkInt ({exp=exp, ty=ty}, pos) = (ErrorMsg.error pos ("Expected INT Found: " ^ (typeToString ty)))

	fun checkIntPair (left, right, pos) =
		(checkInt(left, pos);
		checkInt(right, pos);
		{exp=(), ty=Types.INT})


	fun compatibleTypes (ty1, ty2, pos) =  case (isSubtype(ty1, ty2, pos)) of
									  true  => ({exp=(), ty=ty1})
									| false => ((ErrorMsg.error pos ("Types not the compatible: " ^ (typeToString ty1) ^ " and " ^ (typeToString ty2) ^ "\n"));
												{exp=(), ty=Types.UNDEFINED})

	fun checkPair ({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = (compatibleTypes (ty1, ty2, pos))

	fun getSuper ({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = 	case ((isSubtype(ty1, ty2, pos)), (isSubtype(ty2, ty1, pos))) of
																	  (true, true) => {exp= (), ty=ty1}
																	| (true, false) => {exp= (), ty=ty1}
																	| (false, true) => {exp= (), ty=ty2}
																	| (false, false) => ((ErrorMsg.error pos ("Types not compatible: " ^ (typeToString ty1) ^ " and " ^ (typeToString ty2) ^ "\n")); {exp= (), ty=Types.UNDEFINED})
	fun getType ({exp=exp, ty=ty}): Types.ty = ty

	fun sameTypes ({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = case ty1 = ty2 of
																	true => {exp= (), ty= ty1}
																	| false => ((ErrorMsg.error pos ("Types not the same: " ^ (typeToString ty1) ^ " and " ^ (typeToString ty2) ^ "\n")); {exp= (), ty= ty1})

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


 	fun transTy (tenv, A.NameTy(symbol, pos)) 	= (case lookUpSymbolTENV (tenv, symbol, pos) of
													SOME(ty) => ty
													| NONE => (ErrorMsg.error pos ("Unrecognized symbol: " ^ (Symbol.name symbol)); Types.UNIT))
 	  | transTy (tenv, A.ArrayTy(symbol, pos)) 	= (case lookUpSymbolTENV (tenv, symbol, pos) of
	  												SOME(ty) => Types.ARRAY(ty, unique ())
												  | NONE => Types.ARRAY(Types.UNIT, unique ()))
 	  | transTy (tenv, A.RecordTy(fields)) 		= Types.RECORD((convertRecordFields (tenv, fields)), unique ())

	(*recursive types*)
  	fun processTypeHeaders ({name, ty, pos}, tenv) = Symbol.enter (tenv, name, Types.NAME(name, ref NONE))

	fun checkDuplicationNames ((name, pos), m) = case M.find (m, Symbol.name name) of
														SOME(_) => (ErrorMsg.error pos ("Duplicate recursive type declarations for symbol: " ^ (Symbol.name name)); m)
														| NONE => M.insert (m, Symbol.name name, true)

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
			  | trexp (A.OpExp{left, oper=A.EqOp, right, pos}) 	   	= (checkPair (trexp left, trexp right, pos); {exp=(), ty=Types.INT})
			  | trexp (A.OpExp{left, oper=A.NeqOp, right, pos})  	= (checkPair (trexp left, trexp right, pos); {exp=(), ty=Types.INT})
			  | trexp (A.OpExp{left, oper=A.LtOp, right, pos})  	= (checkPair (trexp left, trexp right, pos); {exp=(), ty=Types.INT})
			  | trexp (A.OpExp{left, oper=A.LeOp, right, pos}) 		= (checkPair (trexp left, trexp right, pos); {exp=(), ty=Types.INT})
			  | trexp (A.OpExp{left, oper=A.GtOp, right, pos}) 		= (checkPair (trexp left, trexp right, pos); {exp=(), ty=Types.INT})
			  | trexp (A.OpExp{left, oper=A.GeOp, right, pos}) 		= (checkPair (trexp left, trexp right, pos); {exp=(), ty=Types.INT})
			  | trexp(A.VarExp(var)) 								= trvar(var)
			  | trexp(A.NilExp) 									= {exp=(), ty=Types.NIL}
			  | trexp(A.IntExp(int)) 								= {exp=(), ty=Types.INT}
			  | trexp(A.StringExp(string, pos)) 					= {exp=(), ty=Types.STRING}
			  | trexp(A.SeqExp(seq)) 								= (trseq seq)
			  | trexp(A.LetExp{decs, body, pos}) =
												  let
												  	val (venv, tenv) = (Symbol.beginScope venv, Symbol.beginScope tenv)
												  	val {venv=new_venv, tenv=new_tenv} = transDecs(venv, tenv, decs)
													val {exp=e, ty=t} = transExp(new_venv, new_tenv) body
												  in
												  	{exp=e, ty=t}
												  end

				| trexp(A.CallExp{func, args, pos}) = (case Symbol.look(venv, func) of
														 SOME(ENV.FunEntry{formals=paramTys, result=ty}) => (paramList (paramTys, args, pos); {exp=(), ty=lookUpActualSymType (ty, pos)}) (* CHECK ALL PARAMETERS*)
														| SOME(ENV.VarEntry{ty=ty}) => (ErrorMsg.error pos ("Symbol is not a function: " ^ (Symbol.name func)); {exp=(), ty=Types.INT})
														| NONE => (ErrorMsg.error pos ("Unrecognized function  " ^ (Symbol.name func)); {exp=(), ty=Types.INT}))
				| trexp(A.AssignExp{var, exp, pos}) = checkPair(trvar var, trexp exp, pos)
				| trexp(A.WhileExp{test, body, pos}) =  let
														val testTy = trexp test
														val bodyTy = trexp body
														in
														(checkInt(testTy, pos); compatibleTypes(#ty bodyTy, Types.UNIT, pos); bodyTy)
														end

				| trexp(A.IfExp{test=test,then'=thenExp,else'=SOME(elseExp),pos=pos}) = let
																							val testTy = trexp test
																							val thenTy = trexp thenExp
																							val elseTy = trexp elseExp
																						in
																							(checkInt(testTy, pos); getSuper (thenTy, elseTy, pos))
																						end


				| trexp(A.IfExp{test=test,then'=thenExp,else'=NONE,pos=pos}) =  let
																				val testTy = trexp test
																				val thenTy = trexp thenExp
																				in
																				(checkInt(testTy, pos); compatibleTypes(#ty thenTy, Types.UNIT, pos); thenTy)
																				end
				| trexp(A.ArrayExp{typ, size, init, pos}) = 	let
																val typ = lookUpSymbolTENV (tenv, typ, pos)
																val sizeExp = trexp size
																val initExp = trexp init
																in
																case typ of
																     SOME(Types.ARRAY(aType, aRef)) =>
																	 		(checkInt(sizeExp, pos);
																			compatibleTypes (aType, getType initExp, pos);
																  			{exp=(), ty=Types.ARRAY(aType, aRef)})
																   | SOME(_) => ((ErrorMsg.error pos ("Tried to construct an array non array type. ")); {exp=(), ty=Types.INT})
																   | NONE => ((ErrorMsg.error pos ("Array type not declared."));
																   				{exp=(), ty=Types.ARRAY(Types.INT, unique ())})
																end
				| trexp(A.RecordExp{fields, typ, pos}) = 	let
																val (smyTypes, recRef) = case lookUpSymbolTENV (tenv, typ, pos) of
																	SOME(Types.RECORD (lst, r)) => (lst, r)
																	| _ => ((ErrorMsg.error pos ("Record type not declared.")); ([], unique ()))
															in
															(map (recList smyTypes) fields;
															{exp=(), ty=Types.RECORD(smyTypes, recRef)})
															end

				| trexp(A.ForExp{var=symbol,escape=escape,
								lo=lo,hi=hi,body=body,pos=pos}) = 	let
																	val (venv', tenv') = (Symbol.beginScope (venv), Symbol.beginScope (tenv))
																	val loTy = trexp lo
																	val hiTy = trexp hi
																	val venv'' = Symbol.enter (venv, symbol, ENV.VarEntry{ty=Types.INT})
																	in
																	(checkInt(loTy, pos);
																	 checkInt(hiTy, pos);
																	 transExp (venv'', tenv) body)
																	end

				| trexp(A.BreakExp(pos)) = {exp=(), ty=Types.UNIT}

			and trvar (A.SimpleVar(id, pos)) 			= {exp=(), ty=(lookUpSymbol (venv, id, pos))}
				| trvar (A.FieldVar(var, id, pos)) 	    = let
															val {exp=exp,ty=ty} = trvar var
														  in
														  	case ty of
																Types.RECORD(typs,r) => (case List.find (fn (s, t) => s = id) typs of
																							  SOME(s, t) => {exp=(), ty=t}
																							| NONE 		 => ((ErrorMsg.error pos ("Accessing a non-existent field")); {exp=(), ty=Types.UNDEFINED}))

															  | _ =>  ((ErrorMsg.error pos ("Accessing a field of a non-record")); {exp=(), ty=Types.UNDEFINED})
														  end
				| trvar (A.SubscriptVar(var, exp, pos)) = let
															val x = checkInt ((trexp exp), pos)
															val {exp=exp,ty=ty} = trvar var
														  in
														  	case lookUpActualSymType ty of
																Types.ARRAY(ty1,r) => {exp=(), ty=ty1}
															  | Types.NAME(ty, r) =>
															  | a =>  ((ErrorMsg.error pos ("Subscript of non-array: " ^ (typeToString a))); {exp=(), ty=Types.UNDEFINED})
														  end

			and trseq ((exp, pos)::nil) = trexp exp
			  | trseq ((exp, pos)::seq) = (trexp exp; trseq seq)
			  | trseq (nil)  			= {exp=(), ty=Types.UNIT}

			and paramList (t::typeList, a::argList, pos) = let
														val {exp=aExp, ty=aTy} = trexp a
														val aTy = lookUpActualSymType (aTy, pos)
													in
														if isSubtype(t, aTy, pos)
														then paramList (typeList, argList, pos)
														else ((ErrorMsg.error pos ("Argument Type Incorrect: " ^ (typeToString t) ^ " and " ^ (typeToString aTy) ^ "\n")); false)
													end
			  | paramList ([], [], pos) = true
			  | paramList ([], a::argList, pos) = ((ErrorMsg.error pos ("Too many arguments for function!")); false)
			  | paramList (t::typeList, [], pos) = ((ErrorMsg.error pos ("Not enough arguments for function!")); false)

			and recList ((symbol, ty)::lst) (field, exp, pos) = (case field = symbol of
							true => let
									val ty1 = lookUpActualSymType (ty, pos)
									val ty2 = lookUpActualSymType ((getType (trexp exp)), pos)
									in
									case isSubtype(ty1, ty2, pos) of
										true  => ()
									  | false => (ErrorMsg.error pos ("Value for field " ^ field ^ " does not match expected type"); ())
									end
						  | false => recList lst (field, exp, pos))
			  | recList [] (field, exp, pos) = (ErrorMsg.error pos ("Record field not found:\t" ^ field); ())

		in
		trexp
		end

		and transDec (A.FunctionDec(lst), {venv, tenv})	= 	let
														  		val (venv', _, params) = (foldr processFunctionHeaders (venv, tenv, []) lst)
															  	val (_, _) = (foldl processFunctionBodies (venv', tenv) (ListPair.zip (lst, params)))
														  	in
															  	(foldl checkDuplicationNames M.empty (map (fn a => (#name a, #pos a)) lst); {venv=venv', tenv=tenv})
															end

		  | transDec (A.TypeDec(lst), {venv, tenv}) = let
														val tenv' = (foldl processTypeHeaders tenv lst)
														val tenv'' = (foldl processTypeBodies tenv' lst)
													  in
													  	(foldl checkDuplicationNames M.empty (map (fn a => (#name a, #pos a)) lst); {venv=venv, tenv=tenv''})
													  end
		  | transDec (A.VarDec({name=name,escape=escape,typ=NONE, init=init, pos=pos}),
		  						{venv, tenv}) = let
												val {exp, ty} = transExp(venv, tenv) init
												in
												( case ty of
													Types.NIL => (ErrorMsg.error pos ("Illegal variable initialization. Cannot be nil."); {venv=Symbol.enter(venv, name, ENV.VarEntry{ty=ty}), tenv=tenv})
												  | _ => {venv=Symbol.enter(venv, name, ENV.VarEntry{ty=ty}), tenv=tenv})



												end
		  | transDec (A.VarDec({name=name, escape=x, typ=SOME(sym, p), init=init, pos=pos}),
		  						{venv, tenv}) = let
												val typ = case lookUpSymbolTENV (tenv, sym, pos) of SOME(ty) => ty | NONE => (ErrorMsg.error pos ("undefined variable " ^ Symbol.name sym); Types.UNDEFINED)
												val {exp=exp,ty=expTy} = transExp (venv, tenv) init
				  								val entry = ENV.VarEntry({ty=typ})
				  							  	val venv = Symbol.enter (venv, name, entry)
				  							  	in
												case expTy of
													Types.NIL => (case typ of Types.RECORD(_, _) => {venv=venv, tenv=tenv} | _ => (ErrorMsg.error pos ("Nil can only be assigned to records."); {venv=venv, tenv=tenv}))
													| _ => (
														case isSubtype (typ, expTy, pos) of
															false => (ErrorMsg.error pos ("Illegal variable initialization. Expected " ^ Symbol.name sym ^ "."); {venv=venv, tenv=tenv})
															| true => {venv=venv, tenv=tenv})
				  							  	end


		and transDecs (venv, tenv, decs) = (foldl transDec {venv=venv, tenv=tenv} decs)

		and processFunctionHeaders ({name=name,params=params,result=SOME((sym, rpos)),body=body,pos=pos}, (venv, tenv, paramList)) = 	let
																																	val x = Int.toString pos
																																	val (params', m) = foldr (fn (p,acc) => transparam(p, tenv, acc)) ([], M.empty) params
																																	val symTy = case lookUpSymbolTENV (tenv, sym, rpos) of
																																					SOME(ty) => ty
																																				  | NONE => (ErrorMsg.error pos ("Unrecognized function result type") ;Types.UNDEFINED)
																																	val fnDec = ENV.FunEntry({formals=map #ty params', result=symTy})
																																	val venv' = Symbol.enter (venv, name, fnDec)
																																in
																																	(venv', tenv, params'::paramList)
																																end
		| processFunctionHeaders ({name=name,params=params,result=NONE,body=body,pos=pos}, (venv, tenv, paramList)) = 	let
																													val x = Int.toString pos
																													val (params', m) = foldr (fn (p,acc) => transparam(p, tenv, acc)) ([], M.empty) params
																													val fnDec = ENV.FunEntry({formals=map #ty params', result=Types.UNIT})
																													val venv' = Symbol.enter (venv, name, fnDec)
																												in
																													(venv', tenv, params'::paramList)
																												end

		and processFunctionBodies (({name, params, result=result, body, pos}, paramList), (venv, tenv)) = case Symbol.look(venv, name) of
																											NONE => (ErrorMsg.error pos("Function body name doesnt exist: " ^ (Symbol.name name)); (venv, tenv))
																									   	  | SOME(ENV.VarEntry {ty})						=> (venv, tenv)
																										  | SOME(ENV.FunEntry {formals=f,result=ty})	=>  let
																										  														val (venv', tenv') = (Symbol.beginScope venv, Symbol.beginScope tenv)
																																								val venv'' = foldl (fn ({name=s, ty=ty}, t) => Symbol.enter (t, s, ENV.VarEntry{ty=ty})) venv' paramList
																										  														val {exp=exp,ty=ty1} = transExp (venv'', tenv') body
																																							in
																																								case ty of
																																									Types.UNIT => ( case ty1 of
																																													Types.UNIT => (venv, tenv)
																																													| a => (ErrorMsg.error pos ("Warning: Procedure " ^ (Symbol.symbol name) ^ " not returning Unit. Found: " ^ (typeToString ty1)); (venv, tenv)))
																																								  | _ => case isSubtype(ty, ty1, pos) of true => (venv, tenv) | false => (ErrorMsg.error pos ("Incompatible return type in function " ^ (Symbol.symbol name) ^ ". Expected: " ^ (typeToString ty) ^ " Found: " ^ (typeToString ty1)) ; (venv, tenv))
																																							end

	fun transVar (venv, tenv, A.SimpleVar(id, pos)) 	  		= {exp=(), ty=(lookUpSymbol (venv, id, pos))}
	  | transVar (venv, tenv, A.FieldVar(var, id, pos)) 		= {exp=(), ty=(lookUpSymbol (venv, id, pos))}
	  | transVar (venv, tenv, A.SubscriptVar(var, exp, pos))	= {exp=(), ty=Types.UNDEFINED}
(*
	* 	API							*
	*  								*)

	fun transProg exp = let val x = transExp (ENV.base_venv, ENV.base_tenv) exp in () end

end

structure Semant :> SemantSig =
struct
	structure A = Absyn
	structure M = SplayMapFn(struct type ord_key = string val compare = String.compare end)
	structure S = SplaySetFn(struct type ord_key = string val compare = String.compare end)
	type venv  = ENV.enventry Symbol.table
	type tenv  = Types.ty Symbol.table
	type expty = {exp: Translate.exp, ty: Types.ty}

	datatype loopTracker = LOOP of Temp.label * loopTracker
						 | NOLOOP
	val loops = ref NOLOOP

    (*								*
	 * 	Private Helper Functions	*
	 *  							*)

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

	fun findHelp e ((a, b)::l, i) = (case e = a of
		  					  true => SOME(b, i + 1)
							 | false => findHelp e (l, (i + 1)))
	  | findHelp e ([], i) = NONE

	fun find e l = findHelp e (l, 0)

	(* Converts fields to (Symbol.symbol * ty) list *)

	(* Retrieves actual type from Type.NAME  *)
	fun lookUpActualSymType (Types.NAME(sym, tyOpt), pos): Types.ty = (case !tyOpt of
												  						SOME(ty) => ty
												  		  			  | NONE	 => (ErrorMsg.error pos ("undefined variable " ^ Symbol.name sym); Types.UNDEFINED))
	 	| lookUpActualSymType (ty, pos): Types.ty = ty;


	fun lookUpSymbol (venv, symbol, pos): Types.ty = case Symbol.look(venv, symbol) of
													   		SOME(ENV.VarEntry {access=_, ty=ty})						=> (lookUpActualSymType (ty, pos))
														  | SOME(ENV.FunEntry {level=_, label=_, formals=_, result=ty})	=> (lookUpActualSymType (ty, pos))
													   	  | NONE														=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); Types.UNDEFINED)

	fun getVarAccess (venv, symbol) = case Symbol.look(venv, symbol) of
										SOME(ENV.VarEntry {access=a, ty=_}) => SOME(a)
										| _									=> NONE

	fun lookUpSymbolTENV (tenv, symbol, pos): Types.ty option = (case Symbol.look(tenv, symbol) of
												   		  	 		SOME(ty)	=> SOME(lookUpActualSymType (ty, pos))
												   	  		  		| NONE		=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); NONE))

	fun lookUpSymbolOpt (venv, SOME(sym, pos)): Types.ty = lookUpSymbol	(venv, sym, pos)
	  | lookUpSymbolOpt (venv, NONE): Types.ty = (ErrorMsg.error 0 ("undefined variable"); Types.UNDEFINED)



  	fun checkDuplicateFields (m, name, pos, str) = case M.find (m, Symbol.name name) of
  												  		SOME(_) => (ErrorMsg.error pos (str ^ " " ^ Symbol.name name))
  												  		| NONE => ();

  	fun convertRecordField (tenv, {name, escape, typ, pos}, (acc, m)) = (checkDuplicateFields(m, name, pos, "Duplicate Record field:");
  																		case Symbol.look (tenv, typ) of
  																			SOME t => ((name, t)::acc, M.insert (m, Symbol.name name, true))
  																		   | NONE  => (ErrorMsg.error pos ("Type " ^ (Symbol.name typ) ^ "not defined."); ((name, Types.UNIT)::acc, M.insert (m, Symbol.name name, true))))

  	fun convertRecordFields (tenv, fields): (Symbol.symbol * Types.ty) list = let val (acc, m) = foldl (fn (f, acc) => convertRecordField(tenv, f, acc)) ([], M.empty) fields in acc end


	fun compatibleTypes (ty1, ty2, pos) =  case (isSubtype(ty1, ty2, pos)) of
									  true  => ty1
									| false => ((ErrorMsg.error pos ("Types not the compatible: " ^ (typeToString ty1) ^ " and " ^ (typeToString ty2) ^ "\n")); Types.UNDEFINED)

	fun checkPair ({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = (compatibleTypes (ty1, ty2, pos))

	fun checkInt ({exp=exp, ty=Types.INT}, pos ) = ()
	  | checkInt ({exp=exp, ty=ty}, pos) = (ErrorMsg.error pos ("Expected INT Found: " ^ (typeToString ty)))

	fun intBinOp (left, right, oper, pos) =
		(checkInt(left, pos);
		checkInt(right, pos);
		{exp=(Translate.transOP (oper, #exp left, #exp right)), ty=Types.INT})

	fun binOp (left, right, oper, pos) =
		(checkPair(left, right, pos);
		{exp=(Translate.transOP (oper, #exp left, #exp right)), ty=Types.INT})

	fun getSuper ({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = 	case ((isSubtype(ty1, ty2, pos)), (isSubtype(ty2, ty1, pos))) of
																	  (true, true) => ty1
																	| (true, false) => ty1
																	| (false, true) => ty2
																	| (false, false) => ((ErrorMsg.error pos ("Types not compatible: " ^ (typeToString ty1) ^ " and " ^ (typeToString ty2) ^ "\n")); Types.UNDEFINED)
	fun getType ({exp=exp, ty=ty}): Types.ty = ty

	fun checkDuplicateFunctionField (m, name, pos) = case M.find (m, Symbol.name name) of
													SOME(_) => (ErrorMsg.error pos ("Duplicate function field " ^ Symbol.name name))
												  | NONE => ();

	fun transparam ({name=name,typ=typ,pos=pos,escape=esc}, tenv, (l, m)) = (	checkDuplicateFields(m, name, pos, "Duplicate Function field:");
																	   	case lookUpSymbolTENV (tenv, typ, pos) of
																			SOME t => ({name=name, ty=t, escape=esc}::l, M.insert (m, Symbol.name name, true))
																		   | NONE  => ({name=name, ty=Types.UNIT, escape=esc}::l, M.insert (m, Symbol.name name, true)));
	(*									*
	 * 	Private Translation Functions	*
	 *  								*)


	 fun transTy (tenv, A.NameTy(symbol, pos)) 	= (case Symbol.look (tenv, symbol) of
														  SOME(ty) => ty
														| NONE => (ErrorMsg.error pos ("Unrecognized Type: " ^ (Symbol.name symbol)); Types.UNIT))
 	   | transTy (tenv, A.ArrayTy(symbol, pos)) 	= (case Symbol.look (tenv, symbol ) of
			  											  SOME(ty) => Types.ARRAY(ty, ref ())
														| NONE => (ErrorMsg.error pos ("Unrecognized Type: " ^ (Symbol.name symbol)); Types.ARRAY(Types.UNIT, ref ())))
 	   | transTy (tenv, A.RecordTy(fields)) 		= Types.RECORD((convertRecordFields (tenv, fields)), ref ())


	(*recursive types*)
  	fun processTypeHeaders ({name, ty, pos}, tenv) = Symbol.enter (tenv, name, Types.NAME(name, ref NONE))

	fun processTypeBodies ({name, ty, pos}, tenv) = case Symbol.look (tenv, name) of
		  												  SOME(Types.NAME(name, r)) => (r := SOME(transTy (tenv, ty)); tenv)
		  												| SOME(_) => (ErrorMsg.error pos ("Unexpected Type for symbol: " ^ (Symbol.name name)); tenv)
		  												| NONE => (ErrorMsg.error pos ("Unrecognized symbol: " ^ (Symbol.name name)); tenv)

	fun getInnerType (tenv, ty, pos) = case ty of
										  SOME(Types.NAME(sym, r)) => (case !r of
										  								SOME(typ) => SOME(typ)
																	  | NONE => (ErrorMsg.error pos ("None type error in type: " ^ (Symbol.name sym)); NONE))
										| SOME(Types.ARRAY(typ, _)) => SOME(typ)
										| SOME(_) => NONE
										| NONE => (ErrorMsg.error pos ("None type error"); NONE)

	fun circularTy (s, SOME(Types.NAME(name, r)), tenv) = (if S.member (s, (Symbol.name name))
															then ( r := SOME(Types.UNDEFINED); true)
															else circularTy ((S.add (s, name)), getInnerType (tenv, Symbol.look (tenv, name), 0), tenv))
	| circularTy (s, SOME(Types.ARRAY(ty, u)), tenv) = 	circularTy (s, getInnerType (tenv, SOME(ty), 0), tenv)
	| circularTy (s, SOME(Types.UNDEFINED), tenv)    = 	((); true)
	| circularTy (s, _, tenv) = false

	fun processRecursiveDefs tenv {name, ty, pos} =  let
														 	val s = S.add (S.empty, name)
															val nameTy = Symbol.look (tenv, name)
															val inner = getInnerType (tenv, nameTy, pos)
															val circular = circularTy (s, inner, tenv)
														 in
														 	if circular
															then (ErrorMsg.error pos ("Circular type: " ^ (Symbol.name name)); ())
															else ()
														 end



	fun transExp (level, venv, tenv) =
		let
			fun trexp (A.OpExp{left, oper=A.PlusOp, right, pos})   	= intBinOp (trexp left, trexp right, A.PlusOp, pos)
			  | trexp (A.OpExp{left, oper=A.MinusOp, right, pos})  	= intBinOp (trexp left, trexp right, A.MinusOp, pos)
			  | trexp (A.OpExp{left, oper=A.TimesOp, right, pos})  	= intBinOp (trexp left, trexp right, A.TimesOp, pos)
			  | trexp (A.OpExp{left, oper=A.DivideOp, right, pos}) 	= intBinOp (trexp left, trexp right, A.DivideOp, pos)
			  | trexp (A.OpExp{left, oper=A.EqOp, right, pos}) 	   	= binOp (trexp left, trexp right, A.EqOp, pos)
			  | trexp (A.OpExp{left, oper=A.NeqOp, right, pos})  	= binOp (trexp left, trexp right, A.NeqOp, pos)
			  | trexp (A.OpExp{left, oper=A.LtOp, right, pos})  	= binOp (trexp left, trexp right, A.LtOp, pos)
			  | trexp (A.OpExp{left, oper=A.LeOp, right, pos}) 		= binOp (trexp left, trexp right, A.LeOp, pos)
			  | trexp (A.OpExp{left, oper=A.GtOp, right, pos}) 		= binOp (trexp left, trexp right, A.GtOp, pos)
			  | trexp (A.OpExp{left, oper=A.GeOp, right, pos}) 		= binOp (trexp left, trexp right, A.GeOp, pos)
			  | trexp(A.VarExp(var)) 								= trvar(var)
			  | trexp(A.NilExp) 									= {exp=(Translate.transNil ()), ty=Types.NIL}
			  | trexp(A.IntExp(i)) 									= {exp=(Translate.transInt i), ty=Types.INT}
			  | trexp(A.StringExp(s, pos)) 							= {exp=(Translate.transString s), ty=Types.STRING}
			  | trexp(A.SeqExp(seq)) 								= 	let
				  															val l = trseq seq
																			val exp = Translate.transSeq (map #exp l)
																			val ty = #ty (List.last (l))
																		in
																			{exp=exp, ty=ty}
																		end
			  | trexp(A.LetExp{decs, body, pos}) =
												  let
												  	val (venv, tenv) = (Symbol.beginScope venv, Symbol.beginScope tenv)
												  	val ({venv=new_venv, tenv=new_tenv}, decList) = transDecs(level, venv, tenv, decs)
													val {exp=body, ty=t} = transExp(level, new_venv, new_tenv) body
												  in
												  	{exp=Translate.transLet (decList, body), ty=t}
												  end

				| trexp(A.CallExp{func, args, pos}) = (case Symbol.look(venv, func) of
														 SOME(ENV.FunEntry{level=_, label=l, formals=paramTys, result=ty}) => {exp=(Translate.transCall (l, (map #exp (paramList (paramTys, args, pos))))), ty=lookUpActualSymType (ty, pos)}
														| SOME(ENV.VarEntry{access=_, ty=_}) => (ErrorMsg.error pos ("Symbol is not a function: " ^ (Symbol.name func)); {exp=(Translate.transNil ()), ty=Types.UNDEFINED})
														| NONE => (ErrorMsg.error pos ("Unrecognized function  " ^ (Symbol.name func)); {exp=(Translate.transNil ()), ty=Types.UNDEFINED}))
				| trexp(A.AssignExp{var, exp, pos}) = let
														val expTy = trexp exp
														val var = trvar var
														in
														{exp=(Translate.transAssign (#exp var, #exp expTy)), ty=checkPair(var, expTy, pos)}
														end
				| trexp(A.WhileExp{test, body, pos}) =  let
														val test = trexp test
														val loopLabel = Translate.beginLoop ()
														val result = (loops := LOOP(loopLabel, !loops); checkInt(test, pos))
														val body = trexp body
														in
														(loops := (case !loops of LOOP(l, last) => last | NOLOOP => NOLOOP);
														{exp=(Translate.transWhile (#exp test, #exp body, loopLabel)), ty=Types.UNIT})
														end

				| trexp(A.IfExp{test=test,then'=thenExp,else'=SOME(elseExp),pos=pos}) = let
																							val test = trexp test
																							val thenExp = trexp thenExp
																							val elseExp = trexp elseExp
																						in
																							(checkInt(test, pos); {exp=Translate.transIf (#exp test, #exp thenExp, SOME(#exp elseExp)), ty=getSuper (thenExp, elseExp, pos)})
																						end


				| trexp(A.IfExp{test=test,then'=thenExp,else'=NONE,pos=pos}) =  let
																				val test = trexp test
																				val thenExp = trexp thenExp
																				in
																				(checkInt(test, pos); {exp=Translate.transIf (#exp test, #exp thenExp, NONE), ty=(#ty thenExp)})
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
																  			{exp=(Translate.transArray (#exp sizeExp, #exp initExp)), ty=Types.ARRAY(aType, aRef)})
																   | SOME(_) => ((ErrorMsg.error pos ("Tried to construct an array non array type. ")); {exp=(Translate.transNil ()), ty=Types.UNDEFINED})
																   | NONE => ((ErrorMsg.error pos ("Array type not declared."));
																   				{exp=(Translate.transArray (#exp sizeExp, Translate.transNil())), ty=Types.ARRAY(Types.UNDEFINED, ref ())})
																end
				| trexp(A.RecordExp{fields, typ, pos}) = 	let
																val (smyTypes, recRef) = case lookUpSymbolTENV (tenv, typ, pos) of
																	SOME(Types.RECORD (lst, r)) => (lst, r)
																	| _ => ((ErrorMsg.error pos ("Record type not declared.")); ([], ref ()))
															in
															{exp=(Translate.transRec (map (recList smyTypes) fields)), ty=Types.RECORD(smyTypes, recRef)}
															end

				| trexp(A.ForExp{var=symbol,escape=esc,
								lo=lo,hi=hi,body=body,pos=pos}) = 	let
																	val (venv', tenv') = (Symbol.beginScope (venv), Symbol.beginScope (tenv))
																	val lo = trexp lo
																	val hi = trexp hi
																	val venv'' = Symbol.enter (venv, symbol, ENV.VarEntry{access=Translate.allocLocal (level) (!esc), ty=Types.INT})
																	val loopLabel = Translate.beginLoop ()
																	val body = (loops := LOOP(loopLabel, !loops);
																					checkInt(lo, pos);
																					checkInt(hi, pos);
																					transExp (level, venv'', tenv) body)
																	in
																	(loops := (case !loops of LOOP(l, last) => last | NOLOOP => NOLOOP);
																	{exp=Translate.transFor (#exp hi, #exp lo, #exp body, loopLabel), ty=Types.UNIT})
																	end

				| trexp(A.BreakExp(pos)) = 	case !loops of
				 							LOOP(label, last) 	=> {exp=(Translate.transBreak (label)), ty=Types.UNIT}
										  | NOLOOP 				=> ((ErrorMsg.error pos ("Break called outside of a loop.")); {exp=(Translate.transNil ()), ty=Types.UNDEFINED})

			and trvar (A.SimpleVar(id, pos)) 			= {exp=(Translate.transSimpleVar (getVarAccess(venv, id), level)), ty=(lookUpSymbol (venv, id, pos))}
				| trvar (A.FieldVar(var, id, pos)) 	    = let
															val {exp=exp,ty=ty} = trvar var
														  in
														  	case ty of
																Types.RECORD(typs,r) => let
																							val index = find id typs
																						in
																						case index of
																						  SOME(t, i) 	=> {exp=(Translate.transRecordVar (exp, i)), ty=t}
																						| NONE 			=> ((ErrorMsg.error pos ("Accessing a non-existent field you cunt")); {exp=(Translate.transNil ()), ty=Types.UNDEFINED})
																						end
															  | _ =>  ((ErrorMsg.error pos ("Accessing a field of a non-record")); {exp=(Translate.transNil ()), ty=Types.UNDEFINED})
														  end
				| trvar (A.SubscriptVar(var, exp, pos)) = let
															val index = trexp exp
															val check = checkInt (index, pos)
															val {exp=exp,ty=ty} = trvar var
														  in
														  	case ty of
																Types.ARRAY(ty1,r) => {exp=(Translate.transArrayVar (exp, (#exp index))), ty=ty1}
															  | _ =>  ((ErrorMsg.error pos ("Subscript of non-array")); {exp=(Translate.transNil ()), ty=Types.UNDEFINED})
														  end

			and trseq ((exp, pos)::nil) = (trexp exp)::nil
			  | trseq ((exp, pos)::seq) = (trexp exp)::(trseq seq)
			  | trseq (nil)  			= [{exp=(Translate.transNil()), ty=Types.UNIT}]

			and paramList (t::typeList, a::argList, pos) = let
																val x = trexp a
																val aTy = lookUpActualSymType (#ty x , pos)
															in
																if isSubtype(t, aTy, pos)
																then x::paramList (typeList, argList, pos)
																else ((ErrorMsg.error pos ("Argument Type Incorrect: " ^ (typeToString t) ^ " and " ^ (typeToString aTy) ^ "\n")); {exp=Translate.transNil (), ty=Types.UNDEFINED}::paramList (typeList, argList, pos))
															end
			  | paramList ([], [], pos) = []
			  | paramList ([], a::argList, pos) = ((ErrorMsg.error pos ("Too many arguments for function!")); [])
			  | paramList (t::typeList, [], pos) = ((ErrorMsg.error pos ("Not enough arguments for function!")); {exp=Translate.transNil (), ty=Types.UNDEFINED}::paramList (typeList, [], pos))


			and recList ((symbol, ty)::lst) (field, exp, pos) = (case field = symbol of
							true => let
									val expTy = trexp exp
									val ty1 = lookUpActualSymType (ty, pos)
									val ty2 = lookUpActualSymType (#ty expTy, pos)
									in
									case isSubtype(ty1, ty2, pos) of
										true  => (#exp expTy)
									  | false => (ErrorMsg.error pos ("Record Arg do not match expected type"); (Translate.transNil ()))
									end
						  | false => recList lst (field, exp, pos))
			  | recList [] (field, exp, pos) = (ErrorMsg.error pos ("Record field not found"); (Translate.transNil ()))

		in
		trexp
		end

		and transDec (level, A.FunctionDec(lst), ({venv, tenv}, l)) = let
														  		val (venv', _, params) = (foldr (fn (e,a) => processFunctionHeaders(level, e, a)) (venv, tenv, []) lst)
															  	val (_, _) = (foldl processFunctionBodies (venv', tenv) (ListPair.zip (lst, params)))
														  	in
															  	({venv=venv', tenv=tenv}, l)
															end

		  | transDec (level, A.TypeDec(lst), ({venv, tenv}, l)) = let
														val tenv' = (foldl processTypeHeaders tenv lst)
														val tenv'' = (foldl processTypeBodies tenv' lst)
														val _ = (map (fn (t) => processRecursiveDefs(tenv') t) lst)
													  in
													  	({venv=venv, tenv=tenv''}, l)
													  end
		  | transDec (level, A.VarDec({name=name,escape=esc,typ=NONE, init=init, pos=pos}),
		  						({venv, tenv}, l)) = let
												val {exp, ty} = transExp(level, venv, tenv) init
												val a = Translate.allocLocal (level) (!esc)
												val result = Translate.transAssign (Translate.transSimpleVar(SOME(a), level), exp)
												in
												({venv=Symbol.enter(venv, name, ENV.VarEntry{access=a, ty=ty}), tenv=tenv}, l@[result])
												end
		  | transDec (level, A.VarDec({name=name, escape=esc, typ=SOME(sym, p), init=init, pos=pos}),
		  						({venv, tenv}, l)) = let
												val typ = case lookUpSymbolTENV (tenv, sym, pos) of SOME(ty) => ty | NONE => (ErrorMsg.error pos ("undefined variable " ^ Symbol.name sym); Types.UNDEFINED)
												val {exp=exp,ty=expTy} = transExp (level, venv, tenv) init
												val a = Translate.allocLocal (level) (!esc)
				  								val entry = ENV.VarEntry({access=a, ty=typ})
				  							  	val venv = Symbol.enter (venv, name, entry)
												val result = Translate.transAssign (Translate.transSimpleVar(SOME(a), level), exp)
				  							  	in
												case expTy of
													Types.NIL => (case typ of
																	Types.RECORD(_, _) 	=> ({venv=venv, tenv=tenv}, result::l)
																	| _ 				=> (ErrorMsg.error pos ("Nil can only be assigned to records."); ({venv=venv, tenv=tenv}, result::l)))
													| _ => (isSubtype (typ, expTy, pos); ({venv=venv, tenv=tenv}, result::l))
				  							  	end


		and transDecs (level, venv, tenv, decs) = (foldl (fn (e, a) => transDec(level, e, a)) ({venv=venv, tenv=tenv}, []) decs)

		and processFunctionHeaders (level, {name=name,params=params,result=SOME((sym, rpos)),body=body,pos=pos}, (venv, tenv, paramList)) = 	let
																																	val x = Int.toString pos
																																	val (params', m) = foldl (fn (p,acc) => transparam(p, tenv, acc)) ([], M.empty) params
																																	val symTy = case lookUpSymbolTENV (tenv, sym, rpos) of
																																					SOME(ty) => ty
																																				  | NONE => (ErrorMsg.error pos ("Unrecognised function result type") ;Types.UNDEFINED)
																																	val nextLevel = Translate.newLevel {parent=level, name=Temp.newlabel(), formals=map (fn a => true) params'}
																																	val fnDec = ENV.FunEntry({level=nextLevel, label=Temp.newlabel(), formals=map #ty params', result=symTy})
																																	val venv' = Symbol.enter (venv, name, fnDec)
																																in
																																	Translate.leaveLevel ();
																																	(venv', tenv, params'::paramList)
																																end
		| processFunctionHeaders (level, {name=name,params=params,result=NONE,body=body,pos=pos}, (venv, tenv, paramList)) = 	let
																													val x = Int.toString pos
																													val (params', m) = foldl (fn (p,acc) => transparam(p, tenv, acc)) ([], M.empty) params
																													val nextLevel = Translate.newLevel {parent=level, name=Temp.newlabel(), formals=map (fn a => true) params'}
																													val fnDec = ENV.FunEntry({level=nextLevel, label=Temp.newlabel(), formals=map #ty params', result=Types.UNIT})
																													val venv' = Symbol.enter (venv, name, fnDec)
																												in
																													Translate.leaveLevel ();
																													(venv', tenv, params'::paramList)
																												end

		and processFunctionBodies (({name, params, result=result, body, pos}, paramList), (venv, tenv)) = case Symbol.look(venv, name) of
																											NONE => (ErrorMsg.error pos("Function body name doesnt exist: " ^ (Symbol.name name)); (venv, tenv))
																									   	  | SOME(ENV.VarEntry (_))						=> (ErrorMsg.error pos("Given name is a variable name: " ^ (Symbol.name name)); (venv, tenv))
																										  | SOME(ENV.FunEntry {level=level, label=_, formals=f,result=ty})	=>  let
																													  														val (venv', tenv') = (Symbol.beginScope venv, Symbol.beginScope tenv)
																																											val venv'' = foldl (fn ({name=s, ty=ty, escape=esc}, t) => Symbol.enter (t, s, ENV.VarEntry{access=Translate.allocLocal (level) (!esc), ty=ty})) venv' paramList
																													  														val {exp=exp,ty=ty1} = transExp (level, venv'', tenv') body
																																											val result = Translate.transBody exp

																																											val _ = Translate.procEntryExit {level=level, body=result}
																																										in
																																											case isSubtype(ty, ty1, pos) of
																																												true => (venv, tenv)
																																											  | false => (ErrorMsg.error pos ("Incompatible return type in function " ^ (Symbol.symbol name) ^ ". Expected: " ^ (typeToString ty) ^ " Found: " ^ (typeToString ty1)) ; (venv, tenv))
																																										end

   (*
	* 	API							*
	*  								*)

	fun transProg exp = (
		FindEscape.findEscape exp;
		Printtree.printtree (TextIO.openOut "results.txt" , Translate.treeStm (#exp (transExp (Translate.outermost, ENV.base_venv, ENV.base_tenv) exp)));
		Translate.getResult ())
end

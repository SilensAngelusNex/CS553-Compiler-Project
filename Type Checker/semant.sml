structure Semant :> SemantSig =
struct
	structure A = Absyn

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


	fun lookUpSymbol (venv, symbol, pos): Types.ty = ( print ("looking up variable: " ^ (Symbol.name symbol) ^ "\n"); case Symbol.look(venv, symbol) of
													   		SOME(ENV.VarEntry {ty})						=> (lookUpActualSymType ty)
														  | SOME(ENV.FunEntry {formals=f,result=ty})	=> (lookUpActualSymType ty)
													   	  | NONE										=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); Types.INT))

	fun lookUpSymbolTENV (tenv, symbol, pos): Types.ty = (case Symbol.look(tenv, symbol) of
												   		  	 	SOME(ty)	=> (lookUpActualSymType ty)
												   	  		  | NONE		=> (ErrorMsg.error pos ("undefined variable " ^ Symbol.name symbol); Types.INT))

	fun lookUpSymbolOpt (venv, SOME(sym, pos)): Types.ty = lookUpSymbol	(venv, sym, pos)
	  | lookUpSymbolOpt (venv, NONE): Types.ty = (ErrorMsg.error 0 ("undefined variable"); Types.INT)

	fun convertRecordField (tenv, {name, escape, typ, pos}): (Symbol.symbol * Types.ty) = (name, lookUpSymbol (tenv, typ, pos));

	fun convertRecordFields (tenv, fields): (Symbol.symbol * Types.ty) list = map (fn (f) => convertRecordField (tenv, f)) fields;


	fun convertFuncField (venv, {name, escape, typ, pos}): Types.ty = lookUpSymbol (venv, typ, pos)

	fun convertFuncFields (venv, fields): Types.ty list = map (fn (field) => convertFuncField (venv, field)) fields;


	fun checkInt ({exp=exp, ty=Types.INT}, pos ) = ()
	  | checkInt (_, pos) = (ErrorMsg.error pos ("Expected INT Found: " ^ "other"))

	fun compare (x, y) = x = y

	fun getType ({exp=exp, ty=ty}): Types.ty = ty
	(*										*
	* 	Insert Into Symbol Table Functions 	*
	*  									*)

	fun insertList (tylist, env, f) = foldl f env tylist

	fun insertType ({name: A.symbol, ty: A.ty, pos: A.pos}, tenv): tenv = 	let
																			val newType = Types.NAME(name, ref NONE)
												 							val tenv = Symbol.enter (tenv, name, newType)
																			in
																		 	tenv
																			end

	fun insertFunc ({name: A.symbol,
					params: A.field list,
					result: (A.symbol * A.pos) option,
					body: A.exp,
					pos: A.pos},
					venv) = case result of
										SOME((sym, p)) => (let
															val fields = convertFuncFields (venv, params)
															val sym = lookUpSymbol (venv, sym, p)
															val entry = ENV.FunEntry({formals=fields, result=sym})
															val venv = Symbol.enter (venv, name, entry)
															in
															venv
															end)
										| NONE		   => venv



	(*									*
	 * 	Private Translation Functions	*
	 *  								*)

	fun transVar (venv, A.SimpleVar(id, pos)) 			= {exp=(), ty=(lookUpSymbol (venv, id, pos))}
 	  | transVar (venv, A.FieldVar(v, id, pos)) 		= {exp=(), ty=(lookUpSymbol (venv, id, pos))}
 	  | transVar (venv, A.SubscriptVar(var, exp, pos)) 	= {exp=(), ty=Types.INT}

 	fun transTy (tenv, A.NameTy(symbol, pos)) 	= Types.NAME(symbol, ref NONE)
 	  | transTy (tenv, A.ArrayTy(symbol, pos)) 	= Types.ARRAY((lookUpSymbol (tenv, symbol, pos)), ref ())
 	  | transTy (tenv, A.RecordTy(fields)) 		= Types.RECORD((convertRecordFields (tenv, fields)), ref ())

	fun transExp (venv, tenv) =
		let
			val x = print "looping\n"
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
												  	val x = print "Let expression\n"
												  	val (venv, tenv) = (Symbol.beginScope venv, Symbol.beginScope tenv)
												  	val {venv=new_venv, tenv=new_tenv} = transDecs(venv, tenv, decs)
												  in
												  	transExp(new_venv, new_tenv) body
												  end

				| trexp(A.CallExp{func, args, pos}) = (case Symbol.look(venv, func) of
														 SOME(ENV.FunEntry{formals=paramTys, result=ty}) => {exp=(), ty=lookUpActualSymType ty} (* CHECK ALL PARAMETERS*)
														| SOME(ENV.VarEntry{ty=ty}) => (ErrorMsg.error pos ("Symbol is not a function: " ^ (Symbol.name func)); {exp=(), ty=Types.INT})
														| NONE => (ErrorMsg.error pos ("Unrecognized function  " ^ (Symbol.name func)); {exp=(), ty=Types.INT}))
				| trexp(A.AssignExp{var, exp, pos}) = checkPair(trvar var, trexp exp, pos)
				| trexp(A.WhileExp{test, body, pos}) =  let
														val (venv, tenv) = (Symbol.beginScope (venv), Symbol.beginScope (tenv))
														val testTy = transExp(venv, tenv) test
														val bodyTy = transExp(venv, tenv) test
														in
														(checkInt(testTy, pos); bodyTy)
														end

				| trexp(A.IfExp{test=test,then'=thenExp,else'=SOME(elseExp),pos=pos}) = let
																						val (venv, tenv) = (Symbol.beginScope (venv), Symbol.beginScope (tenv))
																						val testTy = transExp(venv, tenv) test
																						val thenTy = transExp(venv, tenv) test
																						val elseTy = transExp(venv, tenv) test
																						in
																						(checkInt(testTy, pos); checkPair (thenTy, elseTy, pos))
																						end


				| trexp(A.IfExp{test=test,then'=thenExp,else'=NONE,pos=pos}) =  let
																				val (venv, tenv) = (Symbol.beginScope (venv), Symbol.beginScope (tenv))
																				val testTy = transExp(venv, tenv) test
																				val thenTy = transExp(venv, tenv) test
																				in
																				(checkInt(testTy, pos); thenTy)
																				end
				| trexp(A.ArrayExp{typ, size, init, pos}) = 	let
																val typ = lookUpSymbolTENV (tenv, typ, pos)
																val sizeExp = trexp size
																val initExp = trexp init
																in
																(*typ must be an ARRAY of ty * unique*)
																(*size must be an int type*)
																(*init must be ty in ARRAY of ty * unique*)
																{exp=(), ty=Types.ARRAY(getType initExp, ref ())}
																end
				| trexp(A.RecordExp{fields, typ, pos}) = 	let
															val typ = lookUpSymbolTENV (tenv, typ, pos)
															in
															(*typ must be an ARRAY of ty * unique*)
															(*size must be an int type*)
															(*init must be ty in ARRAY of ty * unique*)
															{exp=(), ty=Types.RECORD([],ref ())}
															end


				(*
				Symbol.symbol * ty) list * unique

				| trexp(A.ForExp{symbol, escape, lo, hi, body, pos}) = let
																		val (venv, tenv) = (Symbol.beginScope (venv), Symbol.beginScope (tenv))
																		val venv = transDec
																		val testTy = transExp(venv, tenv) test
																		val thenTy = transExp(venv, tenv) test
																		in
																		(checkInt(testTy, pos); thenTy)
																		end

				| trexp(A.BreakExp(pos)) =

				*)
				| trexp(l) = (print "anything else\n"; {exp=(), ty=Types.STRING})

			and trvar (A.SimpleVar(id, pos)) 			= (print "simple var\n";{exp=(), ty=lookUpSymbol (venv, id, pos)})
				| trvar (A.FieldVar(v, id, pos)) 	    = {exp=(), ty=Types.INT}
				| trvar (A.SubscriptVar(var, exp, pos)) = {exp=(), ty=Types.INT}

			and trseq ((exp, pos)::nil) = trexp exp
			  | trseq ((exp, pos)::seq) = (trexp exp; trseq seq)
			  | trseq (nil)  			= {exp=(), ty=Types.UNIT}

			and checkIntPair (left, right, pos) =
				(checkInt(left, pos);
				checkInt(right, pos);
				{exp=(), ty=Types.INT})

			and checkPair ({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = case (ty1 = ty2) of
																			true  => ({exp=(), ty=Types.INT})
																		  | false => ((ErrorMsg.error pos ("Incomparable Types: " ^ "other and " ^ "other")); {exp=(), ty=Types.INT})
		in
		trexp
		end

		and transDec (A.FunctionDec(lst), {venv, tenv})		= (print "found a function\n"; {venv=(insertList (lst, venv, insertFunc)), tenv=tenv})
		  | transDec (A.TypeDec(lst), {venv, tenv}) 		= (print "found a type\n"; {venv=venv, tenv=( insertList (lst, tenv, insertType))})
		  | transDec (A.VarDec({name=name,escape=escape,typ=NONE, init=init, pos=pos}),
		  						{venv, tenv}) = let
												val x = print ("inserting a new variable" ^ (Symbol.name name))
												val x = print "\n"
												val {exp, ty} = transExp(venv, tenv) init
												in
												{venv=Symbol.enter(venv, name, ENV.VarEntry{ty=ty}), tenv=tenv}
												end
		  | transDec (A.VarDec({name=name, escape=x, typ=SOME(sym, p), init=init, pos=pos}),
		  						{venv, tenv}) = let
												val typ = lookUpSymbolTENV (tenv, sym, pos)
												val {exp=exp,ty=expTy} = transExp (venv, tenv) init
				  								val entry = ENV.VarEntry({ty=typ})
				  							  	val venv = Symbol.enter (venv, name, entry)
				  							  	in
												(*check whether constraint == to init -- if init exp is nil must be record type 118*)
												(compare (typ, expTy);
				  							  	{venv=venv, tenv=tenv})
				  							  	end


		and transDecs (venv, tenv, decs) = (foldl transDec {venv=venv, tenv=tenv} decs)


	(*								*
	* 	API							*
	*  								*)

	fun transProg exp = let val x = transExp (ENV.base_venv, ENV.base_tenv) exp in () end

end

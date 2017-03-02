structure ENV :> ENVSig =
struct
	type access = string
	type ty = Types.ty

	datatype enventry = VarEntry of {ty: ty}
					  | FunEntry of {formals: ty list, result: ty}

	val tenvs = [
				(SymbolTable.symbol ("int"), Types.INT),
				(SymbolTable.symbol ("string"), Types.STRING),
				(SymbolTable.symbol ("nil"), Types.NIL),
				(SymbolTable.symbol ("unit"), Types.UNIT)
				]


	val base_tenv: ty SymbolTable.table = (foldl (fn ((sym, ty), acc) => SymbolTable.enter(acc, sym, ty)) SymbolTable.empty() tenvs)

	val venvs = [
				 (SymbolTable.symbol ("print"), FunEntry({formals=[Types.STRING], result=Types.UNIT})),
				 (SymbolTable.symbol ("flush"), FunEntry({formals=[], result=Types.UNIT})),
				 (SymbolTable.symbol ("getchar"), FunEntry({formals=[], result=Types.STRING})),
				 (SymbolTable.symbol ("ord"), FunEntry({formals=[Types.STRING], result=Types.INT})),
				 (SymbolTable.symbol ("chr"), FunEntry({formals=[Types.INT], result=Types.STRING})),
				 (SymbolTable.symbol ("size"), FunEntry({formals=[Types.STRING], result=Types.INT})),
				 (SymbolTable.symbol ("substring"), FunEntry({formals=[Types.STRING, Types.INT, Types.INT], result=Types.STRING})),
				 (SymbolTable.symbol ("concat"), FunEntry({formals=[Types.STRING,Types.STRING], result=Types.STRING})),
				 (SymbolTable.symbol ("not"), FunEntry({formals=[Types.INT], result=Types.INT})),
				 (SymbolTable.symbol ("exit"), FunEntry({formals=[Types.INT], result=Types.INT}))
				 ]

	val base_venv: enventry SymbolTable.table = (foldl (fn ((sym, env), acc) => SymbolTable.enter(acc, sym, env)) SymbolTable.empty() venvs)

end

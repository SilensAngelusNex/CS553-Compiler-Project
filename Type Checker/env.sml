structure ENV :> ENVSig =
struct
	type access = string
	type ty = Types.ty

	datatype enventry = VarEntry of {ty: ty}
					  | FunEntry of {formals: ty list, result: ty}

	val tenvs = [
				(Symbol.symbol ("int"), Types.INT),
				(Symbol.symbol ("string"), Types.STRING),
				(Symbol.symbol ("nil"), Types.NIL),
				(Symbol.symbol ("unit"), Types.UNIT)
				]

	val empty: ty Symbol.table = Symbol.empty
	val base_tenv: ty Symbol.table = (foldl (fn ((sym, ty), acc) => Symbol.enter(acc, sym, ty)) empty tenvs)

	val venvs = [
				 (Symbol.symbol ("print"), FunEntry({formals=[Types.STRING], result=Types.UNIT})),
				 (Symbol.symbol ("flush"), FunEntry({formals=[], result=Types.UNIT})),
				 (Symbol.symbol ("getchar"), FunEntry({formals=[], result=Types.STRING})),
				 (Symbol.symbol ("ord"), FunEntry({formals=[Types.STRING], result=Types.INT})),
				 (Symbol.symbol ("chr"), FunEntry({formals=[Types.INT], result=Types.STRING})),
				 (Symbol.symbol ("size"), FunEntry({formals=[Types.STRING], result=Types.INT})),
				 (Symbol.symbol ("substring"), FunEntry({formals=[Types.STRING, Types.INT, Types.INT], result=Types.STRING})),
				 (Symbol.symbol ("concat"), FunEntry({formals=[Types.STRING,Types.STRING], result=Types.STRING})),
				 (Symbol.symbol ("not"), FunEntry({formals=[Types.INT], result=Types.INT})),
				 (Symbol.symbol ("exit"), FunEntry({formals=[Types.INT], result=Types.INT}))
				 ]

	val empty: enventry Symbol.table = Symbol.empty
	val base_venv: enventry Symbol.table = (foldl (fn ((sym, env), acc) => Symbol.enter(acc, sym, env)) empty venvs)

end

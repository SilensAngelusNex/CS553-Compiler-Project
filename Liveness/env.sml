structure ENV :> ENVSig =
struct
	type access = string
	type ty = Types.ty

	datatype enventry = VarEntry of {access: Translate.access, ty: ty}
					  | FunEntry of {level: Translate.level,
						  			label: Temp.label,
									formals: ty list, result: ty}

	val tenvs = [
				(Symbol.symbol ("int"), Types.INT),
				(Symbol.symbol ("string"), Types.STRING),
				(Symbol.symbol ("nil"), Types.NIL),
				(Symbol.symbol ("unit"), Types.UNIT)
				]

	val empty: ty Symbol.table = Symbol.empty
	val base_tenv: ty Symbol.table = (foldl (fn ((sym, ty), acc) => Symbol.enter(acc, sym, ty)) empty tenvs)

	val trans = Translate.outermost

	val venvs = [
				 (Symbol.symbol ("print"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_print", formals=[false]},
				 									 label=Temp.namedlabel "tig_print", formals=[Types.STRING], result=Types.UNIT
														})),
				 (Symbol.symbol ("flush"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_flush", formals=[]}, label=Temp.namedlabel "tig_flush", formals=[], result=Types.UNIT})),
				 (Symbol.symbol ("getchar"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_getchar", formals=[]}, label=Temp.namedlabel "tig_getchar", formals=[], result=Types.STRING})),
				 (Symbol.symbol ("ord"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_ord", formals=[false]}, label=Temp.namedlabel "tig_ord", formals=[Types.STRING], result=Types.INT})),
				 (Symbol.symbol ("chr"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_chr", formals=[false]}, label=Temp.namedlabel "tig_chr", formals=[Types.INT], result=Types.STRING})),
				 (Symbol.symbol ("size"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_size", formals=[false]}, label=Temp.namedlabel "tig_size", formals=[Types.STRING], result=Types.INT})),
				 (Symbol.symbol ("substring"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_substring", formals=[false, false, false]}, label=Temp.namedlabel "tig_substring", formals=[Types.STRING, Types.INT, Types.INT], result=Types.STRING})),
				 (Symbol.symbol ("concat"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_concat", formals=[false, false]}, label=Temp.namedlabel "tig_concat", formals=[Types.STRING,Types.STRING], result=Types.STRING})),
				 (Symbol.symbol ("not"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_not", formals=[false]}, label=Temp.namedlabel "tig_not", formals=[Types.INT], result=Types.INT})),
				 (Symbol.symbol ("exit"), FunEntry({level=Translate.newLevel {parent=trans, name=Temp.namedlabel "tig_exit", formals=[false]}, label=Temp.namedlabel "tig_exit", formals=[Types.INT], result=Types.INT}))
				 ]

	val empty: enventry Symbol.table = Symbol.empty
	val base_venv: enventry Symbol.table = (foldl (fn ((sym, env), acc) => Symbol.enter(acc, sym, env)) empty venvs)

end

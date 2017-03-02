signature ENVSig =
sig
	type access
	type ty
	datatype enventry = VarEntry of {ty: ty}
					  | FunEntry of {formals: ty list, result: ty}

	val base_tenv: ty SymbolTable.table
	val base_venv: enventry SymbolTable.table
end

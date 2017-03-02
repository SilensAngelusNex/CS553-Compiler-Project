signature SymbolTableSig =
sig
	eqtype symbol
	val symbol : string -> symbol
	val name : symbol -> string

	type 'a table
	type 'a node
	val empty : 'a table
	val enter : 'a table * symbol * 'a -> 'a table
	val look : 'a table * symbol -> 'a option

	val leaveScope : 'a table -> 'a table
	val beginScope : 'a table -> 'a table

end

signature SymbolTableSig =
sig
	eqtype symbol
	val symbol : string -> symbol
	val name : symbol -> string

	type table
	type node
	val empty : table
	val enter : table * symbol * node -> table
	val look : table * symbol -> table

	val beginScope : table -> table
	val leaveScope : table -> table
end

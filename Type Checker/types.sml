structure Types =
struct

  type unique = int

  datatype ty =
            RECORD of (Symbol.symbol * ty) list * unique
          | NIL
          | INT
          | STRING
          | ARRAY of ty * unique
	  | NAME of Symbol.symbol * ty option ref
      | UNDEFINED
	  | UNIT

end

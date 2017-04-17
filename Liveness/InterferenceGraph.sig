signature INTERFERENCE_GRAPH =
sig
	type graph
	datatype color = COLOR of Temp.temp
				   | BLANK
	structure TM : ORD_MAP

	val empty : graph
	val registersOnly : graph
	val newColor : unit -> color
	val compare : color * color -> order
	val itemList : graph -> (Temp.temp * color) list
	val keyList : graph -> Temp.temp list

	val addTemp : graph * Temp.temp -> graph
	val addEdge : graph * Temp.temp * Temp.temp * bool -> graph
	val addMove : graph * Temp.temp * Temp.temp -> graph
	val addInter : graph * Temp.temp * Temp.temp -> graph

	val removeNode : graph * Temp.temp -> graph
	val removeNode' : graph * Temp.temp -> graph

	(*val interDegree : graph * Temp.temp -> int*)
	val moveDegree : graph * Temp.temp -> int
	val degree : graph * Temp.temp -> int

	val tempToString : Temp.temp -> string
	val colorToString : color -> string

	val successors: graph * Temp.temp -> Temp.temp list
	val predecessors: graph * Temp.temp -> Temp.temp list

    val graphColor : graph -> color TM.map

	val tempToReg : color TM.map -> Temp.temp -> Temp.temp
end

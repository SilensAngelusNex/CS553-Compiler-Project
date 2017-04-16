signature INTERFERENCE_GRAPH =
sig
	type graph
	type temp
	type color
	structure TM : ORD_MAP
    structure CM : ORD_MAP

	val empty : graph
	val registersOnly : graph
	val newColor : unit -> color

	val itemList : graph -> (temp * color) list
	val keyList : graph -> temp list

	val addTemp : graph * temp -> graph
	val addEdge : graph * temp * temp * bool -> graph
	val addMove : graph * temp * temp -> graph
	val addInter : graph * temp * temp -> graph

	val removeNode : graph * temp -> graph
	val removeNode' : graph * temp -> graph

	(*val interDegree : graph * temp -> int*)
	val moveDegree : graph * temp -> int
	val degree : graph * temp -> int

	val tempToString : temp -> string
	val colorToString : color -> string

	val successors: graph * temp -> temp list
	val predecessors: graph * temp -> temp list

    val graphColor : graph -> graph * color TM.map
end

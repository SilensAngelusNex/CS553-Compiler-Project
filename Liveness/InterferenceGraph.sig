signature INTERFERENCE_GRAPH =
sig
	type graph
	type temp
	val empty : graph
	val itemList : graph -> temp list

	val addTemp : graph * temp -> graph
	val addEdge : graph * temp * temp * bool -> graph
	val addMove : graph * temp * temp -> graph
	val addInter : graph * temp * temp -> graph

	val removeNode: 'a graph * temp -> 'a graph
	val removeNode': 'a graph * temp -> 'a graph
end

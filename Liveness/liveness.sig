signature LIVE =
sig
    type graph
	type node
	type nodeID
	structure F : FUNCGRAPH
	structure S : ORD_SET
	val liveness : TextIO.outstream * Assem.instr list -> graph
    val instr2graph : Assem.instr list -> graph
	val dataAnalysis : graph -> graph
	val show : TextIO.outstream * graph -> unit
end

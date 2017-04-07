signature FLOW =
sig
    structure Graph : FuncGraph

    datatype flowgraph =
            FGRAPH of {
                        control: FuncGraph.graph,
    				    ismove: bool FuncGraph.Table.table
                    }

end

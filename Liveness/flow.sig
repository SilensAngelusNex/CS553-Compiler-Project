signature FLOW =
sig
    structure Graph : FuncGraph

    datatype flowgraph =
            FGRAPH of {
                        control: FuncGraph.graph,
    				    def: Temp.temp list FuncGraph.Table.table,
    				    use: Temp.temp list FuncGraph.Table.table,
    				    ismove: bool FuncGraph.Table.table
                    }

end

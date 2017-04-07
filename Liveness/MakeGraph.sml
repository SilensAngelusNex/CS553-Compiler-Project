structure MakeGraph :> MAKE =
struct

    structure A = Assem
    structure FL = Flow
    structure F = FuncGraph

    fun insertDef (table, def) = F.Table.insert (table, def)
    fun insertUse (table, use) = F.Table.insert (table, use)
    fun insertMov (table, mov) = F.Table.insert (table, mov)

    fun updateGraph ((A.OPER{assem=a, dst=dstLst, src=srcLst, jump=jmp}),
                     (FL.FGraph{control=cntrl, def=defs, use=uses, ismove=mov})) = LF.FGraph {
                                                                                        control=F.addNode (cntrl, ,),
                                                                                        def=(map insertDef srcLst),
                                                                                        use=(map insertUse dstLst),
                                                                                        ismove=insertMov(mov, jmp)
                                                                                    }
      | addDefs ((A.LABEL{assem=a, lab=label}),
                 (FL.FGraph{control=cntrl, def=def, use=use, ismove=mov})) = FL.FGraph {control=cntrl, def=def, use=use, ismove=mov}
      | addDefs ((A.MOVE{assem=a, dst=dst, src=src}),
                 (FL.FGraph{control=cntrl, def=def, use=use, ismove=mov})) = FL.FGraph {
                                                                                        control=cntrl,
                                                                                        def=def,
                                                                                        use=use,
                                                                                        ismove=mov
                                                                                        }


    fun instr2graph instrs: Flow.flowgraph = foldl
                                            updateGraph
                                            (FL.FGRAPH {
                                                control =  F.empty(),
	                                            def     =  F.Table.empty(),
                            				    use     =  F.Table.empty(),
                            				    ismove  =  F.Table.empty()
                                            })
                                            instrs
end

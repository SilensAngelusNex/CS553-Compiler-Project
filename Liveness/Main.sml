structure Main = struct

    structure Tr = Translate
    structure F = MIPSFrame
    (*structure R = RegAlloc*)
    structure C = Canon
    structure G = MIPSGen

    fun getsome (SOME x) = x

    fun emitproc out instrs = app (fn i => TextIO.output(out, Assem.format(Temp.makestring) i)) instrs;

    fun processFrag out (F.STRING(lab,s), instrs) = (TextIO.output (out, F.string(lab, s)); instrs) (* should emit? *)
      | processFrag out(F.PROC{body,frame}, instrs) =
            let
                val stms     = C.linearize body
                val stms'    = C.traceSchedule(C.basicBlocks stms)
                val instrs'  = List.concat(map (G.codegen frame) stms')
            in
                instrs@instrs'
            end


    fun withOpenFile fname f =
        let
            val out = TextIO.openOut fname
        in (f out before TextIO.closeOut out)
            handle e => (TextIO.closeOut out; raise e)
        end

    fun compile filename = withOpenFile (filename ^ ".g") (fn graphOut => withOpenFile (filename ^ ".s") (fn assemOut =>
        let
            val absyn = Parse.parse filename
            val frags = (FindEscape.findEscape absyn; Semant.transProg absyn)
            val x = print ("frags length: " ^ (Int.toString (List.length (frags))) ^"\n")
            val instrs = (foldl (processFrag assemOut) [] frags)
            val graph = Live.instr2graph instrs
			val graph = Live.dataAnalysis graph

        in
			Live.show (graphOut, graph);
            emitproc assemOut instrs
        end))

end

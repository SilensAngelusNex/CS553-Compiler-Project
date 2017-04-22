structure Main = struct

    structure Tr = Translate
    structure F = MIPSFrame
    (*structure R = RegAlloc*)
    structure C = Canon
    structure G = MIPSGen

    (*	fun getsome (SOME x) = x	*)

    fun emitproc out instrs = app (fn i => TextIO.output(out, Assem.format(F.tempName) i)) instrs;

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

    fun copyTextFile (infile: string, outs) =
        let
            val ins = TextIO.openIn infile

            fun helper(copt: char option) =
              case copt of
                   NONE => (TextIO.closeIn ins)
                 | SOME(c) => (TextIO.output1(outs,c); helper(TextIO.input1 ins))
        in
            helper(TextIO.input1 ins)
        end

    fun compile filename = withOpenFile (filename ^ ".s") (fn assemOut =>
        let
            val absyn = Parse.parse filename
            val frags = (FindEscape.findEscape absyn; Semant.transProg absyn)
            val _ = print ("frags length: " ^ (Int.toString (List.length (frags))) ^"\n")
            val instrs = (foldl (processFrag assemOut) [] frags)
            val graph = Live.instr2graph instrs
			val graph = Live.dataAnalysis graph
			val _ = Live.show (TextIO.stdOut, graph)
            val interGraph = Live.makeInterference graph
            val instrs = RegAlloc.regAlloc (instrs, interGraph)
            (*	val _ = copyTextFile("sysspim.s", assemOut)	*)
            (*	val _ = copyTextFile("runtimele.s", assemOut)	*)
        in
			(*Live.show (TextIO.stdOut, graph);*)
            emitproc assemOut instrs
        end)

end

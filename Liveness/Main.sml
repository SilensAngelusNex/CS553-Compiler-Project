structure Main = struct

    structure Tr = Translate
    structure F = MIPSFrame
    (*structure R = RegAlloc*)
    structure C = Canon
    structure G = MIPSGen

    fun getsome (SOME x) = x

    fun emitproc out (F.STRING(lab,s)) = TextIO.output(out, F.string(lab,s))
      | emitproc out (F.PROC{body,frame}) =
        let
            (*  val _ = print ("emit " ^ F.name frame ^ "\n")
            val _ = Printtree.printtree(out,body); *)
            val stms = C.linearize body
            val stms' = C.traceSchedule(C.basicBlocks stms)
            val instrs =   List.concat(map (G.codegen frame) stms')
            val graph = MakeGraph.instr2graph instrs
            val format0 = Assem.format(Temp.makestring)
            (*  val x = print ("instrus length: " ^ (Int.toString (List.length (instrs))) ^"\n")    *)
        in
            app (fn i => TextIO.output(out,format0 i)) instrs
        end

    fun withOpenFile fname f =
        let
            val out = TextIO.openOut fname
        in (f out before TextIO.closeOut out)
            handle e => (TextIO.closeOut out; raise e)
        end

    fun compile filename =
        let
            val absyn = Parse.parse filename
            val frags = (FindEscape.findEscape absyn; Semant.transProg absyn)
            val x = print ("frags length: " ^ (Int.toString (List.length (frags))) ^"\n")
        in
            withOpenFile (filename ^ ".s") (fn out => (app (emitproc out) frags))
        end

end

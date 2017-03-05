structure Parse =
    struct
        structure Mlex = TigerLexFun(structure Tokens = Tokens)

        fun parse filename =
            let
                val file = TextIO.openIn filename
                fun get _ = TextIO.input file
                val lexer = Mlex.makeLexer get
                fun do_it() =
                    let
                        val t = lexer()
                    in
                        print t; print "\n";
                        if substring(t,0,3)="EOF" then () else do_it()
                    end
                in
                    do_it();
                    TextIO.closeIn file
                end

        fun parseToList filename: string list =
            let
                val file = TextIO.openIn filename
                fun get _ = TextIO.input file
                val lexer = Mlex.makeLexer get
                fun do_it (l): string list =
                    let
                        val t = lexer()
                    in
                        if substring(t,0,3)="EOF"
                        then t::l
                        else do_it (t::l)
                    end;
                val ret = do_it []
            in
                TextIO.closeIn file;
                ret
            end
    end

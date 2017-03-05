|                 | AST              | ASM                                          | IR                                |
| :-------------  | :-------------   | :---------------------------------------     |:-------------                     |
| Scope           | Nested by source | Global Scope                                 | Global Scope                      |
| Types           | All Tiger Types  | 8/16/32 bit Ints                             | Machine Word                      |
| Control         | If, while, for.. | cond/uncond branches - false conditions fall | JUMP/CJUMP targets are anywhere   |
| Structure       | Tree             | Sequence of Statements                       | Tree                              |
| # of Variables  | No limit         | # of available registers (27)                | No limit                          |

## IR (Intermediate Representation)
- Moves to a global scope
- Converts everything to a number
-

datatype stm = SEQ of stm * stm
             | LABEL (*l1 :*)
             | JUMP
             | CJUMP
             | MOVE of exp * exp (*Assignment - take this value and put it in this place*)
             | EXP
    and exp of BINOP
             | MEM of exp (*load etc*)
             | TEMP of TEMP.temp (*register*)
             | ESEQ of stm * exp (*do stm and return exp*)
             | NAME (*Refers to a label*)
             | CONST of int
             | CALL of exp * exp * exp list

 datatype fexp = Ex of exp (*value*)
               | Nx of stm (*effect*)
               | Cx of label * label -> stm (*control*)

| Semant          | Translate                                                   | Frame                                        |
| :-------------  | :-------------                                              | :---------------------------------------     |
| Doesn't Know IR | returns fexp                                                |                                              |
| + -> 3,x        | returns Ex(BINOP(x,3))                                      |                                              |
| x               | converts 3 to a black box IR                                |                                              |
| x < 4           | returns Nx(CJUMP(<,x,4, new function, new func for branch)) |                                              |

fun seq a::[] = a
  | seq a::l  = SEQ[a, seq l]
  | seq []    = throw or other

fun unEx(Ex, e) = e
  | unEx(Nx, g) = ESEQ(s, CONST 0)
  | unEx(Cx, f) =
    let val r = Temp.newtemp() (*register*)
        val l1 = Label.newlabel() (*label*)
        val l2 = Label.newlabel() (*label*)
        val b = f (l1, l2)
    in
        ESEQ(
            seq([
                    MOVE(TEMP R, CONST 0),
                    b,
                    LABEL l1,
                    MOVE(TEMP R, CONST 1),
                    LABEL l2
                  ]),
             TEMP r
             )
    end

fun unNx(Ex, e) = EXP(e)
  | unNx(Nx, g) = g
  | unNx(Cx, f) =
    let l1 = newLabel()
    in
        SEQ(f(l1,l1, Label l1))
    end

fun unCx(Ex, e) =
  | unCx(Nx, g) =
  | unCx(Cx, f) = f


 We unEX (effect: Statement) --> unNX (value: expressions)--> unCx (control: label * label -> statement)


 if e1 then e2 else e3

 fun transIf(e1, e2, e3)
    let
        val i1 = unCx e1                // conditional branch T F
        val i2 = unEx e2                 // T  
        val i3 = unEx e3                     // r = e2
                                             // end
                                         // F
                                            // r = e3
                                            // end
        val t = Label.newlabel()
        val f = Label.newlabel()
        val e = Label.newlabel()
        val r = Label.newlabel()
    in
        ESEQ(SEQ [
                i1(t, f)
                LABEL t
                MOVE(TEMP r, i2)
                JUMP(NAME end, [end])
                LABEL f
                MOVE(TEMP r, i3)
                JUMP(NAME end, [end])
                ]
            )
    end;

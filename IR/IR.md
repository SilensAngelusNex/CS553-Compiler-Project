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

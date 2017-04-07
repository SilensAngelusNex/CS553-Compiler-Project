structure Temp :> TEMP =
struct
    type temp = int

    val labelCount = ref 0
    val temps = ref 100

    fun reset () =
	let val () = temps := 100
	    val () = labelCount := 0
	in
	    ()
	end


    fun newtemp() =
    	let val t  = !temps
    	    val () = temps := t+1
    	in
    	    t
    	end

    fun compare (t1, t2) = if t1 > t2
                           then GREATER
                           else if t1 = t2
                                then EQUAL
                                else LESS

    fun makestring t = "t" ^ Int.toString t

    type label = Symbol.symbol

    structure Set = SplaySetFn(struct
      type ord_key = temp
      val compare = compare
    end)

    structure Map = SplayMapFn(struct
      type ord_key = temp
      val compare = compare
    end)

    fun newlabel() =
    	let
            val x  = !labelCount
    	    val () = labelCount := x +1
    	in
    	    Symbol.symbol ("L" ^ Int.toString x)
    	end

    val namedlabel = Symbol.symbol

end

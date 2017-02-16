## Parser - Weston Carvalho and Aaron Liberatore


### Precedence Operators

Our parser incorporates several precedence operators in order to handle shift-reduce conflicts including those associated with arithmetic, then/else confusion, and expressions at the end of control statements

```
%nonassoc THEN
%nonassoc ELSE

%right OF ID ASSIGN DO
%left OR
%left AND
%left EQ NEQ GT GE LT LE
%left PLUS MINUS
%left TIMES DIVIDE
%left UMINUS
```

We ended up with two shift reduce conflicts that we could not get to unresolve. They are both associated with list a list of function declarations and list of type declarations.

The two rules in each of the below grammar declarations are causing the problem
```

funDecs : funDec funDecs                (fn SOME(e) => e::(funDecs (SOME(funDec)))
                                          | NONE => funDecs (SOME(funDec)))
        | funDec                        (fn SOME(e) => e::funDec::[]
                                          | NONE => funDec::[])

typDecs : typeDec typDecs                (fn SOME(e) => e::(typDecs (SOME(typeDec)))
                                          | NONE => typDecs (SOME(typeDec)))
        | typeDec                        (fn SOME(e) => e::typeDec::[]
        | NONE => typeDec::[])
```

Since ml-yak shifts by default and we always want to extend the list, we left the conflicts in our parser.

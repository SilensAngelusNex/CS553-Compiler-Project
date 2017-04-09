LABEL tig_main
MOVE(
	TEMP t173,
	CALL(
		NAME initArray,
			BINOP(MUL,
				CONST 10,
				CONST 4),
			CONST 0))
MOVE(
	TEMP t174,
	CONST 2)
MOVE(
	TEMP t175,
	TEMP t173)
CJUMP(GE,
	TEMP t174,
	CONST 0,
	L36,L37)
LABEL L37
EXP(
	CALL(
		NAME exit,
			CONST 1))
LABEL L38
EXP(
	MEM(
		BINOP(PLUS,
			BINOP(MUL,
				TEMP t174,
				CONST 4),
			TEMP t175)))
JUMP(
	NAME L39)
LABEL L36
CJUMP(LT,
	TEMP t174,
	MEM(
		BINOP(MINUS,
			TEMP t175,
			CONST 4)),
	L38,L40)
LABEL L40
JUMP(
	NAME L37)
LABEL L39
tig_main:
	addi	 t177, t100, 40
	add	 t108, t177, t100
	addi	t178, t100, 0
	add	 t109, t178, t100
	jal initArray

	add	 t173, t176, t100
	addi	t179, t100, 2
	add	 t174, t179, t100
	move	t175, t173
	slt	 t180, t174, t100
beqz t180, L36
j L37
L37:
	addi	t182, t100, 1
	add	 t108, t182, t100
	jal exit

L38:
	addi	t186, t100, 4
	mul	 t174, t186
 mflo t185	add		t184, t185, t175
	lw	 t183, 0(t184)
	j		L39

L36:
	lw	 t188, 4(t175)
	slt	 t187, t174, t188
beqz t187, L40
j L38
L40:
	j		L37

L39:

tig_main:
	j		L21
L21:
	addi	t155, t100, 0
	add		t152, t155, t100
L22:
	mov	t153, t152
	beq		t153, t100, L24
	j		 L23
L24:
	addi	t156, t100, 40
	add		t154, t156, t100
L25:
	j		L26

L20:
	addi	t157, t100, 1
	add		t152, t157, t100
	j		L21

L23:
	addi	t158, t100, 30
	add		t154, t158, t100
	j		L25

L26:

tig_main:
	j		L28
L28:
	addi	t202, t100, 0
	add		t199, t202, $r0
L29:
	mov	t200, t199
	beq		t200, t100, L31
	j		 L30
L31:
	addi	t203, t100, 40
	add		t201, t203, $r0
L32:
	mov	t102, t201
	j		L33

L27:
	addi	t204, t100, 1
	add		t199, t204, $r0
	j		L29

L30:
	addi	t205, t100, 30
	add		t201, t205, $r0
	j		L32

L33:

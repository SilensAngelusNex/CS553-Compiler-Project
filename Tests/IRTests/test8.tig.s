tig_main:
	j		L25
L25:
	addi	t169, t100, 0
	add		t166, t169, $r0
L26:
	mov	t167, t166
	beq		t167, t100, L28
	j		 L27
L28:
	addi	t170, t100, 40
	add		t168, t170, $r0
L29:
	mov	t102, t168
	j		L30

L24:
	addi	t171, t100, 1
	add		t166, t171, $r0
	j		L26

L27:
	addi	t172, t100, 30
	add		t168, t172, $r0
	j		L29

L30:

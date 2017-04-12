tig_main:
	addi	t357, t100, 40
	add		t108, t357, $r0
	addi	t358, t100, 0
	add		t109, t358, $r0
	jal		initArray

	add		t355, t356, $r0
	mov	t102, t355
	j		L107

L107:

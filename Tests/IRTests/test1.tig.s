tig_main:
	addi	t182, t100, 40
	add		t108, t182, $r0
	addi	t183, t100, 0
	add		t109, t183, $r0
	jal		initArray

	add		t180, t181, $r0
	mov	t102, t180
	j		L17

L17:

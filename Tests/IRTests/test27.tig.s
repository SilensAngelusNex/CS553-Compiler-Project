L40:
	mov	t106, t238
	jr		t107

L41:
tig_main:
	addi	t240, t100, 0
	add		t237, t240, $r0
	mov	t108, t105
	addi	t242, t100, 2
	add		t109, t242, $r0
	jal		L40

	add		t102, t241, $r0
	j		L42

L42:

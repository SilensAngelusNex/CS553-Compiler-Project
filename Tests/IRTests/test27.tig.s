L34:
	mov	t106, t180
	jr		t107

L35:
tig_main:
	addi	t182, t100, 0
	add		t179, t182, $r0
	mov		t108, t105
	addi	t184, t100, 2
	add		t109, t184, $r0
	jal		L34

	add		t102, t183, $r0
	j		L36

L36:

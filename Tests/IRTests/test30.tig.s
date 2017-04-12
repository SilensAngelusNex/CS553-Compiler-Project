tig_main:
	addi	t255, t100, 40
	add		t108, t255, $r0
	addi	t256, t100, 0
	add		t109, t256, $r0
	jal		initArray

	add		t251, t254, $r0
	addi	t257, t100, 2
	add		t252, t257, $r0
	mov	t253, t251
	slt		t258, t252, t100
	beqz	t258, L46
	j		L47
L47:
	addi	t260, t100, 1
	add		t108, t260, $r0
	jal		exit

L48:
	addi	t264, t100, 4
	mul		t252, t264
	mflo	t263
	add		t262, t263, t253
	lw		t261, 0(t262)
	add		t102, t261, $r0
	j		L49

L46:
	lw		t266, -4(t253)
	slt		t265, t252, t266
	beqz	t265, L50
	j		L48
L50:
	j		L47

L49:

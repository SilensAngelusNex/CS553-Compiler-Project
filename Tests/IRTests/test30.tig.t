tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t286, $sp, -4
	move	$sp, t286
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t287, $sp, -36
	move	$sp, t287
	li		t288, 11
	move	$a0, t288
	li		$a1, 0
	jal		tig_initArray

	move	t289, $v0
	move	t282, t289
	li		t290, 10
	sw		t290, 0(t282)
	addi	t291, t282, 4
	move	t283, t291
	li		t284, 2
	move	t285, t283
	slt		t292, t284, $zero
	beqz	t292, L72
	j		L73
L73:
	li		$a0, 1
	jal		tig_exit

	move	t293, $v0
L74:
	li		t296, 4
	mult	t284, t296
	mflo	t295
	add		t294, t295, t285
	lw		$v0, 0(t294)
	addi	t297, $sp, 36
	move	$sp, t297
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	li		$a0, 0
	jal		tig_exit

	move	t298, $v0
	j		L75

L72:
	lw		t300, -4(t285)
	slt		t299, t284, t300
	beqz	t299, L76
	j		L74
L76:
	j		L73

L75:

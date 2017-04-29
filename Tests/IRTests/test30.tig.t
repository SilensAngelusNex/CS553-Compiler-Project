tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t289, $sp, -8
	move	$sp, t289
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t290, $sp, -36
	move	$sp, t290
	li		$a0, 10
	li		$a1, 3
	jal		tig_initArray

	move	t291, $v0
	move	t285, t291
	addi	t292, t285, 4
	move	t286, t292
	li		t287, 2
	move	t288, t286
	slt		t293, t287, $zero
	beqz	t293, L67
	j		L68
L68:
	li		$a0, 1
	jal		tig_exit

	move	t294, $v0
L69:
	li		t297, 4
	mult	t287, t297
	mflo	t296
	add		t295, t296, t288
	lw		$v0, 0(t295)
	addi	t298, $sp, 36
	move	$sp, t298
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
	jr		$ra

L67:
	lw		t300, -4(t288)
	slt		t299, t287, t300
	beqz	t299, L71
	j		L69
L71:
	j		L68

L70:

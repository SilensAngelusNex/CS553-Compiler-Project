L43:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t233, $a1
	move	t234, $a2
	move	$fp, $sp
	addi	t238, $sp, -8
	move	$sp, t238
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t239, $sp, -36
	move	$sp, t239
	lw		$a0, 0($fp)
	addi	t240, t233, 1
	move	$a1, t240
	jal		L42

	move	t241, $v0
	li		$v0, 0
	addi	t242, $sp, 36
	move	$sp, t242
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

L47:
L42:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t232, $a1
	move	$fp, $sp
	addi	t245, $sp, -8
	move	$sp, t245
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t246, $sp, -36
	move	$sp, t246
	lw		t244, 0($fp)
	move	t243, t232
	la		t235, L44
	move	$a0, t244
	move	$a1, t243
	move	$a2, t235
	jal		L43

	move	t247, $v0
	la		t236, L45
	move	$v0, t236
	addi	t248, $sp, 36
	move	$sp, t248
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

L49:
tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t250, $sp, -4
	move	$sp, t250
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t251, $sp, -36
	move	$sp, t251
	move	t249, $fp
	la		t237, L46
	move	$a0, t249
	li		$a1, 0
	move	$a2, t237
	jal		L43

	move	t252, $v0
	move	$v0, t252
	addi	t253, $sp, 36
	move	$sp, t253
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

	move	t254, $v0
	j		L51

L51:

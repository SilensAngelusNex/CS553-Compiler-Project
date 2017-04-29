L42:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t238, $a1
	move	t239, $a2
	move	$fp, $sp
	addi	t244, $sp, -8
	move	$sp, t244
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t245, $sp, -36
	move	$sp, t245
	move	t236, t238
	move	t237, t239
	lw		$a0, 0($fp)
	addi	t246, t236, 1
	move	$a1, t246
	jal		L41

	move	t247, $v0
	li		$v0, 0
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

L46:
L41:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t242, $a1
	move	$fp, $sp
	addi	t251, $sp, -8
	move	$sp, t251
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t252, $sp, -36
	move	$sp, t252
	move	t235, t242
	lw		t250, 0($fp)
	move	t249, t235
	la		t240, L43
	move	$a0, t250
	move	$a1, t249
	move	$a2, t240
	jal		L42

	move	t253, $v0
	la		t241, L44
	move	$v0, t241
	addi	t254, $sp, 36
	move	$sp, t254
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

L48:
tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t256, $sp, -8
	move	$sp, t256
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t257, $sp, -36
	move	$sp, t257
	move	t255, $fp
	la		t243, L45
	move	$a0, t255
	li		$a1, 0
	move	$a2, t243
	jal		L42

	move	t258, $v0
	move	$v0, t258
	addi	t259, $sp, 36
	move	$sp, t259
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

L50:

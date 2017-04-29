tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t205, $sp, -8
	move	$sp, t205
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t206, $sp, -36
	move	$sp, t206
	li		$a0, 8
	jal		tig_allocRecord

	move	t207, $v0
	move	t203, t207
	li		t208, 0
	sw		t208, 0($v0)
	li		t209, 0
	sw		t209, 4($v0)
	move	t204, t203
	move	$v0, t204
	addi	t210, $sp, 36
	move	$sp, t210
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

L29:

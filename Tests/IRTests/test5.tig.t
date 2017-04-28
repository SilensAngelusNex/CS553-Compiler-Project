tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t203, $sp, -4
	move	$sp, t203
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t204, $sp, -36
	move	$sp, t204
	li		$a0, 8
	jal		tig_allocRecord

	move	t205, $v0
	move	t201, t205
	li		t206, 0
	sw		t206, 0($v0)
	li		t207, 0
	sw		t207, 4($v0)
	move	t202, t201
	move	$v0, t202
	addi	t208, $sp, 36
	move	$sp, t208
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

	move	t209, $v0
	j		L28

L28:

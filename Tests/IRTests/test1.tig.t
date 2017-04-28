tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t143, $sp, -4
	move	$sp, t143
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t144, $sp, -36
	move	$sp, t144
	li		t145, 11
	move	$a0, t145
	li		$a1, 0
	jal		tig_initArray

	move	t146, $v0
	move	t141, t146
	li		t147, 10
	sw		t147, 0(t141)
	addi	t148, t141, 4
	move	t142, t148
	move	$v0, t142
	addi	t149, $sp, 36
	move	$sp, t149
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

	move	t150, $v0
	j		L0

L0:

tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t313, $sp, -4
	move	$sp, t313
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t314, $sp, -36
	move	$sp, t314
	li		t312, 2
	addi	t315, t312, 3
	move	$v0, t315
	addi	t316, $sp, 36
	move	$sp, t316
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

	move	t317, $v0
	j		L85

L85:

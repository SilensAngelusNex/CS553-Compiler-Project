tig_main:
	move	$fp, $sp
	sw		$a0, 0($fp)
	addi	t340, $sp, -4
	move	$sp, t340
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t341, $sp, -36
	move	$sp, t341
	li		t339, 3
	move	$v0, t339
	addi	t342, $sp, 36
	move	$sp, t342
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
	lw		$fp, 0($fp)
	jr		$ra

L72:

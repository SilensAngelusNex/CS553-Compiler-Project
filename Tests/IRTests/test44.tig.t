tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t318, $sp, -8
	move	$sp, t318
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t319, $sp, -36
	move	$sp, t319
	li		t317, 0
	li		t317, 0
	li		$v0, 0
	addi	t320, $sp, 36
	move	$sp, t320
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

L79:

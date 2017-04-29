tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1493, $sp, -12
	move	$sp, t1493
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1494, $sp, -36
	move	$sp, t1494
	li		t1491, 3
	li		t1492, 0
L674:
	slt		t1495, t1492, t1491
	beqz	t1495, L672
	j		L675
L672:
	addi	t1496, $sp, 36
	move	$sp, t1496
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

L675:
	addi	t1497, t1492, 1
	move	t1492, t1497
	la		t1490, L673
	move	$a0, t1490
	jal		tig_print

	move	t1498, $v0
	j		L674

L676:

tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t269, $sp, -8
	move	$sp, t269
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t270, $sp, -36
	move	$sp, t270
	li		t266, 0
	li		t267, 100
	li		t268, 0
L60:
	slt		t271, t268, t267
	beqz	t271, L59
	j		L61
L59:
	li		$v0, 0
	addi	t272, $sp, 36
	move	$sp, t272
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

L61:
	addi	t273, t268, 1
	move	t268, t273
	addi	t274, t266, -1
	move	t266, t274
	j		L60

L62:

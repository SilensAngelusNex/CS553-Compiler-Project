tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t265, $sp, -4
	move	$sp, t265
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t266, $sp, -36
	move	$sp, t266
	li		t262, 0
	li		t263, 100
	li		t264, 0
L63:
	slt		t267, t264, t263
	beqz	t267, L62
	j		L64
L62:
	li		$v0, 0
	addi	t268, $sp, 36
	move	$sp, t268
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

	move	t269, $v0
	j		L65

L64:
	addi	t270, t264, 1
	move	t264, t270
	addi	t271, t262, 1
	move	t262, t271
	j		L63

L65:

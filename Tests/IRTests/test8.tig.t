tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t263, $sp, -8
	move	$sp, t263
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t264, $sp, -36
	move	$sp, t264
	j		L53
L53:
	li		t260, 0
L54:
	move	t261, t260
	beq		t261, $zero, L56
	j		 L55
L56:
	li		t262, 40
L57:
	move	$v0, t262
	addi	t265, $sp, 36
	move	$sp, t265
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

L52:
	li		t260, 1
	j		L54

L55:
	li		t262, 30
	j		L57

L58:

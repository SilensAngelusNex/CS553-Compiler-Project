L97:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t330, $a1
	move	$fp, $sp
	addi	t332, $sp, -8
	move	$sp, t332
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t333, $sp, -36
	move	$sp, t333
	move	$v0, t330
	addi	t334, $sp, 36
	move	$sp, t334
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

L99:
L98:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t331, $a1
	move	$fp, $sp
	addi	t335, $sp, -8
	move	$sp, t335
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t336, $sp, -36
	move	$sp, t336
	addi	t337, t331, 1
	move	$v0, t337
	addi	t338, $sp, 36
	move	$sp, t338
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

L100:
tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t339, $sp, -4
	move	$sp, t339
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t340, $sp, -36
	move	$sp, t340
	li		$v0, 0
	addi	t341, $sp, 36
	move	$sp, t341
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

	move	t342, $v0
	j		L101

L101:

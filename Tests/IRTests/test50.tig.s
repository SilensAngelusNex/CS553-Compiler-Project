L13:
	move	$fp, $sp
	sw		$a0, 0($fp)
	move	$a1, $a1
	move	$a0, $a2
	addi	$v0, $sp, 4
	move	$sp, $v0
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	$v0, $sp, -36
	move	$sp, $v0
	sub		$v0, $a1, $a0
	move	$v0, $v0
	addi	$a0, $sp, 36
	move	$sp, $a0
	lw		$a0, 0($sp)
	move	$s0, $a0
	lw		$a0, -4($sp)
	move	$s1, $a0
	lw		$a0, -8($sp)
	move	$s2, $a0
	lw		$a0, -12($sp)
	move	$s3, $a0
	lw		$a0, -16($sp)
	move	$s4, $a0
	lw		$a0, -20($sp)
	move	$s5, $a0
	lw		$a0, -24($sp)
	move	$s6, $a0
	lw		$a0, -28($sp)
	move	$s7, $a0
	lw		$a0, -32($sp)
	move	$ra, $a0
	move	$sp, $fp
	lw		$a0, 0($fp)
	move	$fp, $a0
	jr		$ra

L14:
tig_main:
	move	$a0, $fp
	li		$v0, 3
	move	$a1, $v0
	li		$v0, 4
	move	$a2, $v0
	jal		L13

	move	$v0, $v0
	jr		$ra

L15:

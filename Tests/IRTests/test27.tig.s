L114:
	move	$fp, $sp
	sw		$a0, 0($fp)
	move	$v0, $a1
	addi	$a0, $sp, -4
	move	$sp, $a0
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	$a0, $sp, -36
	move	$sp, $a0
	addi	$a0, $sp, 36
	move	$sp, $a0
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

L115:
tig_main:
	li		$v0, 0
	move	$a0, $fp
	li		$v0, 2
	move	$a1, $v0
	jal		L114

	jr		$ra

L116:

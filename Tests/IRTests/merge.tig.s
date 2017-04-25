L848:
	move	$fp, $sp
	sw		$a0, 0($fp)
	addi	$v0, $sp, -4
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
	lw		$v1, 0($a1)
	lw		$v0, 0($a2)
	slt		$v0, $v1, $v0
	beqz	$v0, L850
	j		L849
L850:
	li		$v0, 0
L851:
	beq		$v0, $zero, L853
	j		 L852
L853:
	li		$a0, 8
	jal		tig_allocRecord

	move	$v1, $v0
	lw		$v1, 0($a2)
	sw		$v1, 0($v0)
	addi	$v0, $v0, 4
	move	$v1, $v0
	lw		$a0, 0($fp)
	lw		$a2, 4($a2)
	jal		L848

	sw		$v0, 0($v1)
	move	$v0, $v1
L854:
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

L849:
	li		$v0, 1
	j		L851

L852:
	li		$a0, 8
	jal		tig_allocRecord

	move	$v1, $v0
	lw		$v1, 0($a1)
	sw		$v1, 0($v0)
	addi	$v0, $v0, 4
	move	$v1, $v0
	lw		$a0, 0($fp)
	lw		$a1, 4($a1)
	jal		L848

	sw		$v0, 0($v1)
	move	$v0, $v1
	j		L854

L855:
tig_main:
	move	$fp, $sp
	sw		$a0, 0($fp)
	addi	$v0, $sp, -4
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
	move	$a0, $fp
	li		$a1, 0
	li		$a2, 0
	jal		L848

	li		$v0, 0
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

L856:

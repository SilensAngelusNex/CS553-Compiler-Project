L57:
	move	$fp, $sp
	sw		$a0, 0($fp)
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
	beq		$a1, $zero, L58
	j		L59
L59:
	li		$v0, 0
L60:
	beq		$v0, $zero, L62
	j		 L61
L62:
	move	$v1, $a1
	lw		$a0, 0($fp)
	addi	$v0, $a1, -1
	move	$a1, $v0
	jal		L57

	mul		$v1, $v0
	mflo	$v0
L63:
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

L58:
	li		$v0, 1
	j		L60

L61:
	li		$v0, 1
	j		L63

L64:
tig_main:
	move	$a0, $fp
	li		$v0, 10
	move	$a1, $v0
	jal		L57

	jr		$ra

L65:

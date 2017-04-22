L96:		.asciiz		"str2"
L95:		.asciiz		" "
L94:		.asciiz		"str"
L93:
	move	$fp, $sp
	sw		$a0, 0($fp)
	move	$v1, $a1
	move	$v0, $a2
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
	lw		$a0, 0($fp)
	addi	$v0, $v1, 1
	move	$a1, $v0
	jal		L92

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

L97:
L92:
	move	$fp, $sp
	sw		$a0, 0($fp)
	move	$v1, $a1
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
	lw		$v0, 0($fp)
	la		$a2, L94
	move	$a0, $v0
	move	$a1, $v1
	jal		L93

	la		$v0, L95
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

L98:
tig_main:
	move	$v0, $fp
	la		$v1, L96
	move	$a0, $v0
	li		$v0, 0
	move	$a1, $v0
	move	$a2, $v1
	jal		L93

	jr		$ra

L99:

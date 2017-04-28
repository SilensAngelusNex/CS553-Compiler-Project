L67:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t273, $a1
	move	$fp, $sp
	addi	t274, $sp, -8
	move	$sp, t274
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t275, $sp, -36
	move	$sp, t275
	move	$v0, t273
	addi	t276, $sp, 36
	move	$sp, t276
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

L68:
tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t277, $sp, -4
	move	$sp, t277
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t278, $sp, -36
	move	$sp, t278
	li		t272, 0
	move	$a0, $fp
	li		$a1, 2
	jal		L67

	move	t279, $v0
	move	$v0, t279
	addi	t280, $sp, 36
	move	$sp, t280
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

	move	t281, $v0
	j		L69

L69:

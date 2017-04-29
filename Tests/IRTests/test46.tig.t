tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t324, $sp, -8
	move	$sp, t324
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t325, $sp, -36
	move	$sp, t325
	li		t321, 0
	beq		t321, $zero, L80
	j		L81
L81:
	li		t322, 0
L82:
	beq		t321, $zero, L84
	j		 L83
L84:
	li		t323, 0
L85:
	move	$v0, t323
	addi	t326, $sp, 36
	move	$sp, t326
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

L80:
	li		t322, 1
	j		L82

L83:
	li		t323, 1
	j		L85

L86:

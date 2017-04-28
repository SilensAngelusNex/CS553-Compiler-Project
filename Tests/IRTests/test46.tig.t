tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t326, $sp, -4
	move	$sp, t326
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t327, $sp, -36
	move	$sp, t327
	li		t323, 0
	beq		t323, $zero, L89
	j		L90
L90:
	li		t324, 0
L91:
	beq		t323, $zero, L93
	j		 L92
L93:
	li		t325, 0
L94:
	move	$v0, t325
	addi	t328, $sp, 36
	move	$sp, t328
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

	move	t329, $v0
	j		L95

L89:
	li		t324, 1
	j		L91

L92:
	li		t325, 1
	j		L94

L95:

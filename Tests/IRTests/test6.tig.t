L32:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t211, $a1
	move	t212, $a2
	move	$fp, $sp
	addi	t215, $sp, -8
	move	$sp, t215
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t216, $sp, -36
	move	$sp, t216
	lw		$a0, 0($fp)
	addi	t217, t211, 1
	move	$a1, t217
	jal		L31

	move	t218, $v0
	move	$v0, t218
	addi	t219, $sp, 36
	move	$sp, t219
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

L35:
L31:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t210, $a1
	move	$fp, $sp
	addi	t222, $sp, -8
	move	$sp, t222
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t223, $sp, -36
	move	$sp, t223
	lw		t221, 0($fp)
	move	t220, t210
	la		t213, L33
	move	$a0, t221
	move	$a1, t220
	move	$a2, t213
	jal		L32

	move	t224, $v0
	move	$v0, t224
	addi	t225, $sp, 36
	move	$sp, t225
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

L37:
tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t227, $sp, -4
	move	$sp, t227
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t228, $sp, -36
	move	$sp, t228
	move	t226, $fp
	la		t214, L34
	move	$a0, t226
	li		$a1, 0
	move	$a2, t214
	jal		L32

	move	t229, $v0
	move	$v0, t229
	addi	t230, $sp, 36
	move	$sp, t230
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

	move	t231, $v0
	j		L39

L39:

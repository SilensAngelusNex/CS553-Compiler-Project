L32:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t214, $a1
	move	t215, $a2
	move	$fp, $sp
	addi	t219, $sp, -8
	move	$sp, t219
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t220, $sp, -36
	move	$sp, t220
	move	t212, t214
	move	t213, t215
	lw		$a0, 0($fp)
	addi	t221, t212, 1
	move	$a1, t221
	jal		L31

	move	t222, $v0
	move	$v0, t222
	addi	t223, $sp, 36
	move	$sp, t223
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
	move	t217, $a1
	move	$fp, $sp
	addi	t226, $sp, -8
	move	$sp, t226
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t227, $sp, -36
	move	$sp, t227
	move	t211, t217
	lw		t225, 0($fp)
	move	t224, t211
	la		t216, L33
	move	$a0, t225
	move	$a1, t224
	move	$a2, t216
	jal		L32

	move	t228, $v0
	move	$v0, t228
	addi	t229, $sp, 36
	move	$sp, t229
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
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t231, $sp, -8
	move	$sp, t231
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t232, $sp, -36
	move	$sp, t232
	move	t230, $fp
	la		t218, L34
	move	$a0, t230
	li		$a1, 0
	move	$a2, t218
	jal		L32

	move	t233, $v0
	move	$v0, t233
	addi	t234, $sp, 36
	move	$sp, t234
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

L39:

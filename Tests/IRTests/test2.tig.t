tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t155, $sp, -4
	move	$sp, t155
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t156, $sp, -36
	move	$sp, t156
	li		t157, 11
	move	$a0, t157
	li		$a1, 0
	jal		tig_initArray

	move	t158, $v0
	move	t151, t158
	li		t159, 10
	sw		t159, 0(t151)
	addi	t160, t151, 4
	move	t152, t160
	li		t153, 2
	move	t154, t152
	slt		t161, t153, $zero
	beqz	t161, L3
	j		L4
L4:
	li		$a0, 1
	jal		tig_exit

	move	t162, $v0
L5:
	li		t165, 4
	mult	t153, t165
	mflo	t164
	add		t163, t164, t154
	lw		$v0, 0(t163)
	addi	t166, $sp, 36
	move	$sp, t166
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

	move	t167, $v0
	j		L6

L3:
	lw		t169, -4(t154)
	slt		t168, t153, t169
	beqz	t168, L7
	j		L5
L7:
	j		L4

L6:

tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t161, $sp, -8
	move	$sp, t161
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t162, $sp, -36
	move	$sp, t162
	li		$a0, 10
	li		$a1, 6
	jal		tig_initArray

	move	t163, $v0
	move	t157, t163
	addi	t164, t157, 4
	move	t158, t164
	li		t159, 2
	move	t160, t158
	slt		t165, t159, $zero
	beqz	t165, L7
	j		L8
L8:
	li		$a0, 1
	jal		tig_exit

	move	t166, $v0
L9:
	li		t169, 4
	mult	t159, t169
	mflo	t168
	add		t167, t168, t160
	lw		$v0, 0(t167)
	addi	t170, $sp, 36
	move	$sp, t170
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

L7:
	lw		t172, -4(t160)
	slt		t171, t159, t172
	beqz	t171, L11
	j		L9
L11:
	j		L8

L10:

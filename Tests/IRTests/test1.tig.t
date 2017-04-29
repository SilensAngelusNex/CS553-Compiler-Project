tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t145, $sp, -8
	move	$sp, t145
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t146, $sp, -36
	move	$sp, t146
	li		$a0, 10
	li		$a1, 2
	jal		tig_initArray

	move	t147, $v0
	move	t141, t147
	addi	t148, t141, 4
	move	t142, t148
	li		t143, 11
	move	t144, t142
	slt		t149, t143, $zero
	beqz	t149, L0
	j		L1
L1:
	li		$a0, 1
	jal		tig_exit

	move	t150, $v0
L2:
	li		t153, 4
	mult	t143, t153
	mflo	t152
	add		t151, t152, t144
	lw		$v0, 0(t151)
	addi	t154, $sp, 36
	move	$sp, t154
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

L0:
	lw		t156, -4(t144)
	slt		t155, t143, t156
	beqz	t155, L4
	j		L2
L4:
	j		L1

L3:

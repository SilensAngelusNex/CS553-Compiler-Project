L16:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t184, $a1
	move	$fp, $sp
	addi	t190, $sp, -8
	move	$sp, t190
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t191, $sp, -36
	move	$sp, t191
	beq		t184, $zero, L17
	j		L18
L18:
	li		t185, 0
L19:
	move	t186, t185
	beq		t186, $zero, L21
	j		 L20
L21:
	move	t189, t184
	lw		$a0, 0($fp)
	addi	t192, t184, -1
	move	$a1, t192
	jal		L16

	move	t193, $v0
	move	t188, t193
	mult	t189, t188
	mflo	t194
	move	t187, t194
L22:
	move	$v0, t187
	addi	t195, $sp, 36
	move	$sp, t195
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

L17:
	li		t185, 1
	j		L19

L20:
	li		t187, 1
	j		L22

L23:
tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t196, $sp, -4
	move	$sp, t196
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t197, $sp, -36
	move	$sp, t197
	move	$a0, $fp
	li		$a1, 10
	jal		L16

	move	t198, $v0
	move	$v0, t198
	addi	t199, $sp, 36
	move	$sp, t199
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

	move	t200, $v0
	j		L25

L25:

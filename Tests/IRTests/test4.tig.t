L18:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t190, $a1
	move	$fp, $sp
	addi	t193, $sp, -8
	move	$sp, t193
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t194, $sp, -36
	move	$sp, t194
	move	t186, t190
	beq		t186, $zero, L19
	j		L20
L20:
	li		t187, 0
L21:
	move	t188, t187
	beq		t188, $zero, L23
	j		 L22
L23:
	move	t192, t186
	lw		$a0, 0($fp)
	addi	t195, t186, -1
	move	$a1, t195
	jal		L18

	move	t196, $v0
	move	t191, t196
	mult	t192, t191
	mflo	t197
	move	t189, t197
L24:
	move	$v0, t189
	addi	t198, $sp, 36
	move	$sp, t198
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

L19:
	li		t187, 1
	j		L21

L22:
	li		t189, 1
	j		L24

L25:
tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t199, $sp, -8
	move	$sp, t199
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t200, $sp, -36
	move	$sp, t200
	move	$a0, $fp
	li		$a1, 10
	jal		L18

	move	t201, $v0
	move	$v0, t201
	addi	t202, $sp, 36
	move	$sp, t202
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

L27:

tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t179, $sp, -8
	move	$sp, t179
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t180, $sp, -36
	move	$sp, t180
	li		$a0, 8
	jal		tig_allocRecord

	move	t181, $v0
	move	t174, t181
	move	t182, $v0
	move	t177, t182
	la		t173, L14
	sw		t173, 0(t177)
	li		t183, 1000
	sw		t183, 4($v0)
	move	t175, t174
	move	t184, t175
	move	t178, t184
	la		t176, L15
	sw		t176, 0(t178)
	lw		$v0, 4(t175)
	addi	t185, $sp, 36
	move	$sp, t185
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

L16:

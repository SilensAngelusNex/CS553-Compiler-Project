tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t176, $sp, -4
	move	$sp, t176
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t177, $sp, -36
	move	$sp, t177
	li		$a0, 8
	jal		tig_allocRecord

	move	t178, $v0
	move	t171, t178
	move	t179, $v0
	move	t174, t179
	la		t170, L11
	sw		t170, 0(t174)
	li		t180, 1000
	sw		t180, 4($v0)
	move	t172, t171
	move	t181, t172
	move	t175, t181
	la		t173, L12
	sw		t173, 0(t175)
	move	$v0, t172
	addi	t182, $sp, 36
	move	$sp, t182
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

	move	t183, $v0
	j		L13

L13:

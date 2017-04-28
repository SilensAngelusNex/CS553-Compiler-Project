tig_main:
	sw		$a0, 0($sp)
	move	$fp, $sp
	addi	t258, $sp, -4
	move	$sp, t258
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t259, $sp, -36
	move	$sp, t259
	j		L55
L55:
	li		t255, 0
L56:
	move	t256, t255
	beq		t256, $zero, L58
	j		 L57
L58:
	li		t257, 40
L59:
	move	$v0, t257
	addi	t260, $sp, 36
	move	$sp, t260
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

	move	t261, $v0
	j		L60

L54:
	li		t255, 1
	j		L56

L57:
	li		t257, 30
	j		L59

L60:

tig_main:
	li		$v0, 40
	move	$a0, $v0
	li		$a1, 0
	jal		tig_initArray

	li		$a1, 2
	slt		$a0, $a1, $zero
	beqz	$a0, L10
	j		L11
L11:
	li		$a0, 1
	jal		exit

	move	$a0, $v0
L12:
	li		$a0, 4
	mul		$a1, $a0
	mflo	$a0
	add		$v0, $a0, $v0
	lw		$v0, 0($v0)
	jr		$ra

L10:
	lw		$a0, -4($v0)
	slt		$a0, $a1, $a0
	beqz	$a0, L14
	j		L12
L14:
	j		L11

L13:

tig_main:
	li		$a2, 0
	li		$a1, 100
	li		$a0, 0
L108:
	slt		$v0, $a0, $a1
	beqz	$v0, L107
	j		L109
L107:
	li		$v0, 0
	jr		$ra

L109:
	addi	$a0, $a0, 1
	addi	$a2, $a2, 1
	j		L108

L110:

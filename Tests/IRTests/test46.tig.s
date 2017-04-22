tig_main:
	li		$a0, 0
	beq		$a0, $zero, L22
	j		L23
L23:
	li		$v0, 0
L24:
	beq		$a0, $zero, L26
	j		 L25
L26:
	li		$v0, 0
L27:
	jr		$ra

L22:
	li		$v0, 1
	j		L24

L25:
	li		$v0, 1
	j		L27

L28:

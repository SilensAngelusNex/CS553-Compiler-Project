tig_main:
	j		L101
L101:
	li		$v0, 0
L102:
	beq		$v0, $zero, L104
	j		 L103
L104:
	li		$v0, 40
L105:
	jr		$ra

L100:
	li		$v0, 1
	j		L102

L103:
	li		$v0, 30
	j		L105

L106:

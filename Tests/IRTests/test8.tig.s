tig_main:
	j		L30
L30:
	li		$v0, 0
L31:
	beq		$v0, $zero, L33
	j		 L32
L33:
	li		$v0, 40
L34:
	jr		$ra

L29:
	li		$v0, 1
	j		L31

L32:
	li		$v0, 30
	j		L34

L35:

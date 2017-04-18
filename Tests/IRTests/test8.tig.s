tig_main:
	j		L123
L123:
	li		$v0, 0
L124:
	beq		$v0, $zero, L126
	j		 L125
L126:
	li		$v0, 40
L127:
	jr		$ra

L122:
	li		$v0, 1
	j		L124

L125:
	li		$v0, 30
	j		L127

L128:

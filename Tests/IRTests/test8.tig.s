tig_main:
	j		L39
L39:
	li		$v0, 0
	move	$v1, $v0
L40:
	move	$v0, $v1
	beq		$v0, $zero, L42
	j		 L41
L42:
	li		$v0, 40
	move	$v1, $v0
L43:
	move	$v0, $v1
	jr		$ra

L38:
	li		$v0, 1
	move	$v1, $v0
	j		L40

L41:
	li		$v0, 30
	move	$v1, $v0
	j		L43

L44:

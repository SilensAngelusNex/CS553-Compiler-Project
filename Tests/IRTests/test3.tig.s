L17:		.asciiz		"Somebody"
L16:		.asciiz		"Nobody"
tig_main:
	li		$a0, 8
	jal		tig_allocRecord

	move	$a1, $v0
	move	$a0, $v0
	la		$a2, L16
	sw		$a2, 0($a0)
	li		$a0, 1000
	sw		$a0, 4($v0)
	move	$v0, $a1
	move	$a0, $v0
	la		$a1, L17
	sw		$a1, 0($a0)
	jr		$ra

L18:

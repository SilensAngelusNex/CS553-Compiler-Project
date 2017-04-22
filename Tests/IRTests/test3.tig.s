L14:		.asciiz		"Somebody"
L13:		.asciiz		"Nobody"
tig_main:
	la		$a0, L13
	li		$a1, 1000
	jal		allocRecord

	li		$a0, 8
	add		$a0, $a0, $v0
	la		$a1, L14
	sw	$a1, 0($a0)
	jr		$ra

L15:

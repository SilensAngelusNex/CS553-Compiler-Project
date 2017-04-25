tig_main:
	li		$a0, 8
	jal		tig_allocRecord

	move	$a1, $v0
	li		$a0, 0
	sw		$a0, 0($v0)
	li		$a0, 0
	sw		$a0, 4($v0)
	move	$v0, $a1
	jr		$ra

L10:

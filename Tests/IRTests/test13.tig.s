L112:		.asciiz		"df"
L111:		.asciiz		"a"
tig_main:
	la		$a1, L111
	la		$a2, L112
	jal		tig_stringEqual

	jr		$ra

L113:

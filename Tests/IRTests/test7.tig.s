L112:		.asciiz		"str2"
L111:		.asciiz		" "
L110:		.asciiz		"str"
L109:
	mov	t248, t245
	addi	t298, t294, 1
	add		t249, t298, t240
	jal		L108

	addi	t299, t240, 0
	add		t246, t299, t240
	jr		t247

L113:
L108:
	mov	t248, t245
	mov	t249, t292
	la		t250, L110
	jal		L109

	la		t246, L111
	jr		t247

L114:
tig_main:
	mov	t248, t245
	addi	t302, t240, 0
	add		t249, t302, t240
	la		t250, L112
	jal		L109

	j		L115

L115:

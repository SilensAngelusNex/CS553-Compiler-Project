L133:		.asciiz		"str2"
L132:		.asciiz		" "
L131:		.asciiz		"str"
L130:
	mov	t108, t105
	addi	t404, t400, 1
	add		t109, t404, $r0
	jal		L129

	addi	t405, t100, 0
	add		t106, t405, $r0
	jr		t107

L134:
L129:
	mov	t108, t105
	mov	t109, t398
	la		t110, L131
	jal		L130

	la		t106, L132
	jr		t107

L135:
tig_main:
	mov	t108, t105
	addi	t408, t100, 0
	add		t109, t408, $r0
	la		t110, L133
	jal		L130

	add		t102, t407, $r0
	j		L136

L136:

L140:		.asciiz		"str2"
L139:		.asciiz		" "
L138:		.asciiz		"str"
L137:
	move	t108, t105
	addi	t301, t297, 1
	add	 t109, t301, t100
	jal L136

	addi	t302, t100, 0
	add	 t106, t302, t100
	jr	 t107

L141:
L136:
	move	t108, t105
	move	t109, t295
	add	t110, t100, t100
	jal L137

	add	t106, t100, t100
	jr	 t107

L142:
tig_main:
	move	t108, t105
	addi	t305, t100, 0
	add	 t109, t305, t100
	add	t110, t100, t100
	jal L137

	j	 L143

L143:

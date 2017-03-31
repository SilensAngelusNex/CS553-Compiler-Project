L166:		.asciiz		"str2"
L165:		.asciiz		" "
L164:		.asciiz		"str"
L168:
	move	t108, t105
	addi	t290, t286, 1
	add	 t109, t290, t100
	jal L160

	addi	t291, t100, 0
	add	 t106, t291, t100
	j	 L167

L167:
L170:
	move	t108, t105
	move	t109, t284
	add	t110, t100, t100
	jal L163

	add	t106, t100, t100
	j	 L169

L169:
L172:
	move	t108, t105
	addi	t294, t100, 0
	add	 t109, t294, t100
	add	t110, t100, t100
	jal L163

	j	 L171

L171:

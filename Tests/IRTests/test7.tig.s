L29:
L24
	move	'd0, 's0
	addi	'd0, 's0, 0
	add	 'd0, 's0, 's1
	add	'd0, 's0, 's1
	jal 's0

	j	 L28

L28:
L31:
L22
	move	'd0, 's0
	addi	'd0, 's0, 1
	add	 'd0, 's0, 's1
	jal 's0

	addi	'd0, 's0, 0
	add	 'd0, 's0, 's1
	j	 L30

L30:
str
 
L33:
L24
	move	'd0, 's0
	move	'd0, 's0
	add	'd0, 's0, 's1
	jal 's0

	add	'd0, 's0, 's1
	j	 L32

L32:
str2

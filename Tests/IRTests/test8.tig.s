L43:
	addi	'd0, 's0, 10
	addi	'd0, 's0, ~20
	addi	'd0, 's0, 31
	srlv	'd0, 's0, 's1
	add		'd0, 's0, 's1
	addi	'd0, 's0, 0
	beq		's0, 's1, L37
	j L36
L37:
	addi	'd0, 's0, 1
	add	 'd0, 's0, 's1
L38:
	move	'd0, 's0
	addi	'd0, 's0, 0
	beq	 's0, 's1, L40
	j L39
L40:
	addi	'd0, 's0, 40
	add	 'd0, 's0, 's1
L41:
	j	 L42

L36:
	addi	'd0, 's0, 0
	add	 'd0, 's0, 's1
	j	 L38

L39:
	addi	'd0, 's0, 30
	add	 'd0, 's0, 's1
	j	 L41

L42:

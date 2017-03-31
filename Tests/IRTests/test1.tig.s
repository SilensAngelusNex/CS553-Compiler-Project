L35:
initArray
	addi	'd0, 's0, 10
	addi	'd0, 's0, 4
	mul	 's0, 's1
 	mflo 'd0	add	 'd0, 's0, 's1
	addi	'd0, 's0, 0
	add	 'd0, 's0, 's1
	jal 's0

	add	 'd0, 's0, 's1
	j	 L34

L34:

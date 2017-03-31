L234:
	addi	t610, t552, 10
	addi	 t609, t610, ~20
	addi	t611, t552, 31
	srlv	 t608, t609, t611	add	 t604, t608, t552
	addi	t612, t552, 0
	beq	 t604, t612, L228
j L227
L228:
	addi	t613, t552, 1
	add	 t605, t613, t552
L229:
	move	t606, t605
	addi	t614, t552, 0
	beq	 t606, t614, L231
j L230
L231:
	addi	t615, t552, 40
	add	 t607, t615, t552
L232:
	j	 L233

L227:
	addi	t616, t552, 0
	add	 t605, t616, t552
	j	 L229

L230:
	addi	t617, t552, 30
	add	 t607, t617, t552
	j	 L232

L233:

tig_main:
	addi	t326, t100, 10
	addi	 t325, t326, ~20
	addi	t327, t100, 31
	srlv	 t324, t325, t327	add	 t320, t324, t100
	addi	t328, t100, 0
	beq	 t320, t328, L152
j L151
L152:
	addi	t329, t100, 1
	add	 t321, t329, t100
L153:
	move	t322, t321
	addi	t330, t100, 0
	beq	 t322, t330, L155
j L154
L155:
	addi	t331, t100, 40
	add	 t323, t331, t100
L156:
	j	 L157

L151:
	addi	t332, t100, 0
	add	 t321, t332, t100
	j	 L153

L154:
	addi	t333, t100, 30
	add	 t323, t333, t100
	j	 L156

L157:

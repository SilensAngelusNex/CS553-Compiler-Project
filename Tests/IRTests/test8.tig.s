tig_main:
	j		L18
L18:
	li		t162, 0
	move	t159, t162
L19:
	move	t160, t159
	beq		t160, t100, L21
	j		 L20
L21:
	li		t163, 40
	move	t161, t163
L22:
	move	t102, t161
	jr		t107

L17:
	li		t164, 1
	move	t159, t164
	j		L19

L20:
	li		t165, 30
	move	t161, t165
	j		L22

L23:

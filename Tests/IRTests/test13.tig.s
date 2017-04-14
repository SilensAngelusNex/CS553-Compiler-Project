L24:		.asciiz		"df"
L23:		.asciiz		"a"
tig_main:
	move	t212, t162
	la		t209, L23
	move	t211, t209
	la		t210, L24
	move	t165, t212
	move	t166, t211
	move	t167, t210
	jal		stringEqual

	move	t159, t213
	jr		t164

L25:

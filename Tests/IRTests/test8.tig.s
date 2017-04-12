tig_main:
	j		L248
L248:
	addi	t742, t100, 0
	add		t739, t742, $r0
L249:
	mov	t740, t739
	beq		t740, t100, L251
	j		 L250
L251:
	addi	t743, t100, 40
	add		t741, t743, $r0
L252:
	mov	t102, t741
	j		L253

L247:
	addi	t744, t100, 1
	add		t739, t744, $r0
	j		L249

L250:
	addi	t745, t100, 30
	add		t741, t745, $r0
	j		L252

L253:

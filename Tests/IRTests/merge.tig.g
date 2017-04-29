Oper Node:	0	L1289:

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	1		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t108 
	Defs:	
Oper Node:	2		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t106 
	Defs:	
Move Node:	3		move	'd0, 's0

	Ins:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t109 
	Defs:	t2199 
Move Node:	4		move	'd0, 's0

	Ins:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 
	Defs:	t106 
Oper Node:	5		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2260 
	Uses:	t105 
	Defs:	t2260 
Move Node:	6		move	'd0, 's0

	Ins:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2260 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t2260 
	Defs:	t105 
Oper Node:	7		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t122 
	Defs:	
Oper Node:	8		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t123 
	Defs:	
Oper Node:	9		sw		's1, -8('s0)

	Ins:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t125 t126 t127 t128 t129 
	Uses:	t105 t124 
	Defs:	
Oper Node:	10		sw		's1, -12('s0)

	Ins:	t100 t105 t106 t107 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t126 t127 t128 t129 
	Uses:	t105 t125 
	Defs:	
Oper Node:	11		sw		's1, -16('s0)

	Ins:	t100 t105 t106 t107 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t127 t128 t129 
	Uses:	t105 t126 
	Defs:	
Oper Node:	12		sw		's1, -20('s0)

	Ins:	t100 t105 t106 t107 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t128 t129 
	Uses:	t105 t127 
	Defs:	
Oper Node:	13		sw		's1, -24('s0)

	Ins:	t100 t105 t106 t107 t128 t129 
	Outs:	t100 t105 t106 t107 t129 
	Uses:	t105 t128 
	Defs:	
Oper Node:	14		sw		's1, -28('s0)

	Ins:	t100 t105 t106 t107 t129 
	Outs:	t100 t105 t106 t107 
	Uses:	t105 t129 
	Defs:	
Oper Node:	15		sw		's1, -32('s0)

	Ins:	t100 t105 t106 t107 
	Outs:	t100 t105 t106 
	Uses:	t105 t107 
	Defs:	
Oper Node:	16		addi	'd0, 's0, -36

	Ins:	t100 t105 t106 
	Outs:	t100 t106 t2261 
	Uses:	t105 
	Defs:	t2261 
Move Node:	17		move	'd0, 's0

	Ins:	t100 t106 t2261 
	Outs:	t100 t105 t106 
	Uses:	t2261 
	Defs:	t105 
Oper Node:	18		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 t2263 
	Uses:	t106 
	Defs:	t2263 
Oper Node:	19		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2263 
	Outs:	t100 t105 t106 t2262 
	Uses:	t2263 
	Defs:	t2262 
Oper Node:	20		lw		'd0, -8('s0)

	Ins:	t100 t105 t106 t2262 
	Outs:	t100 t105 t106 
	Uses:	t2262 
	Defs:	t108 
Oper Node:	21	
	Ins:	t100 t105 t106 
	Outs:	t100 t102 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	22		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	23	
	Ins:	t100 t102 t105 t106 
	Outs:	t100 t102 t105 t106 
	Uses:	
	Defs:	
Move Node:	24		move	'd0, 's0

	Ins:	t100 t102 t105 t106 
	Outs:	t100 t105 t106 t2264 
	Uses:	t102 
	Defs:	t2264 
Move Node:	25		move	'd0, 's0

	Ins:	t100 t105 t106 t2264 
	Outs:	t100 t105 t106 t2254 
	Uses:	t2264 
	Defs:	t2254 
Move Node:	26		move	'd0, 's0

	Ins:	t100 t105 t106 t2254 
	Outs:	t100 t105 t106 t2256 
	Uses:	t2254 
	Defs:	t2256 
Oper Node:	27		la		'd0, L1290

	Ins:	t100 t105 t106 t2256 
	Outs:	t100 t105 t106 t2200 t2256 
	Uses:	
	Defs:	t2200 
Move Node:	28		move	'd0, 's0

	Ins:	t100 t105 t106 t2200 t2256 
	Outs:	t100 t105 t106 t2256 
	Uses:	t2200 
	Defs:	t108 
Oper Node:	29	
	Ins:	t100 t105 t106 t2256 
	Outs:	t100 t102 t103 t105 t106 t2256 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	30		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	31	
	Ins:	t100 t102 t103 t105 t106 t2256 
	Outs:	t100 t102 t103 t105 t106 t2256 
	Uses:	
	Defs:	
Move Node:	32		move	'd0, 's0

	Ins:	t100 t102 t103 t105 t106 t2256 
	Outs:	t100 t103 t105 t106 t2256 t2265 
	Uses:	t102 
	Defs:	t2265 
Move Node:	33		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2256 t2265 
	Outs:	t100 t103 t105 t106 t2255 t2256 
	Uses:	t2265 
	Defs:	t2255 
Oper Node:	34		slt		'd0, 's0, 's1

	Ins:	t100 t103 t105 t106 t2255 t2256 
	Outs:	t100 t103 t105 t106 t2266 
	Uses:	t2255 t2256 
	Defs:	t2266 
Oper Node:	35		beqz	's0, L1291
	j		L1292

	Ins:	t100 t103 t105 t106 t2266 
	Outs:	t100 t103 t105 t106 
	Uses:	t2266 
	Defs:	
Oper Node:	36	L1292:

	Ins:	t100 t103 t105 t106 
	Outs:	t100 t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	37		li		'd0, 0

	Ins:	t100 t103 t105 t106 
	Outs:	t100 t103 t105 t106 t2201 
	Uses:	
	Defs:	t2201 
Oper Node:	38	L1293:

	Ins:	t100 t103 t105 t106 t2201 
	Outs:	t100 t103 t105 t106 t2201 
	Uses:	
	Defs:	
Move Node:	39		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2201 
	Outs:	t100 t103 t105 t106 t2204 
	Uses:	t2201 
	Defs:	t2204 
Oper Node:	40		beq		's0, 's1, L1299
	j		 L1298

	Ins:	t100 t103 t105 t106 t2204 
	Outs:	t103 t105 t106 
	Uses:	t100 t2204 
	Defs:	t100 
Oper Node:	41	L1299:

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	42		li		'd0, 0

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 t2205 
	Uses:	
	Defs:	t2205 
Oper Node:	43	L1300:

	Ins:	t103 t105 t106 t2205 
	Outs:	t103 t105 t106 t2205 
	Uses:	
	Defs:	
Move Node:	44		move	'd0, 's0

	Ins:	t103 t105 t106 t2205 
	Outs:	t102 t103 t105 t106 
	Uses:	t2205 
	Defs:	t102 
Oper Node:	45		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2267 
	Uses:	t105 
	Defs:	t2267 
Move Node:	46		move	'd0, 's0

	Ins:	t102 t103 t106 t2267 
	Outs:	t102 t103 t105 t106 
	Uses:	t2267 
	Defs:	t105 
Oper Node:	47		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	48		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	49		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	50		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	51		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	52		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	53		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	54		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	55		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	56		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	57		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	58		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	59	L1291:

	Ins:	t100 t103 t105 t106 
	Outs:	t100 t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	60		li		'd0, 1

	Ins:	t100 t103 t105 t106 
	Outs:	t100 t103 t105 t106 t2201 
	Uses:	
	Defs:	t2201 
Oper Node:	61		j		L1293


	Ins:	t100 t103 t105 t106 t2201 
	Outs:	t100 t103 t105 t106 t2201 
	Uses:	
	Defs:	
Oper Node:	62	L1298:

	Ins:	t105 t106 
	Outs:	t105 t106 
	Uses:	
	Defs:	
Oper Node:	63		lw		'd0, 0('s0)

	Ins:	t105 t106 
	Outs:	t105 t106 t2269 
	Uses:	t106 
	Defs:	t2269 
Oper Node:	64		lw		'd0, 0('s0)

	Ins:	t105 t106 t2269 
	Outs:	t105 t106 t2268 
	Uses:	t2269 
	Defs:	t2268 
Oper Node:	65		lw		'd0, -8('s0)

	Ins:	t105 t106 t2268 
	Outs:	t105 t106 
	Uses:	t2268 
	Defs:	t108 
Oper Node:	66	
	Ins:	t105 t106 
	Outs:	t102 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	67		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	68	
	Ins:	t102 t105 t106 
	Outs:	t102 t105 t106 
	Uses:	
	Defs:	
Move Node:	69		move	'd0, 's0

	Ins:	t102 t105 t106 
	Outs:	t105 t106 t2270 
	Uses:	t102 
	Defs:	t2270 
Move Node:	70		move	'd0, 's0

	Ins:	t105 t106 t2270 
	Outs:	t105 t106 t2257 
	Uses:	t2270 
	Defs:	t2257 
Move Node:	71		move	'd0, 's0

	Ins:	t105 t106 t2257 
	Outs:	t105 t106 t2259 
	Uses:	t2257 
	Defs:	t2259 
Oper Node:	72		la		'd0, L1294

	Ins:	t105 t106 t2259 
	Outs:	t105 t106 t2202 t2259 
	Uses:	
	Defs:	t2202 
Move Node:	73		move	'd0, 's0

	Ins:	t105 t106 t2202 t2259 
	Outs:	t105 t106 t2259 
	Uses:	t2202 
	Defs:	t108 
Oper Node:	74	
	Ins:	t105 t106 t2259 
	Outs:	t102 t103 t105 t106 t2259 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	75		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	76	
	Ins:	t102 t103 t105 t106 t2259 
	Outs:	t102 t103 t105 t106 t2259 
	Uses:	
	Defs:	
Move Node:	77		move	'd0, 's0

	Ins:	t102 t103 t105 t106 t2259 
	Outs:	t103 t105 t106 t2259 t2271 
	Uses:	t102 
	Defs:	t2271 
Move Node:	78		move	'd0, 's0

	Ins:	t103 t105 t106 t2259 t2271 
	Outs:	t103 t105 t106 t2258 t2259 
	Uses:	t2271 
	Defs:	t2258 
Oper Node:	79		slt		'd0, 's1, 's0

	Ins:	t103 t105 t106 t2258 t2259 
	Outs:	t103 t105 t106 t2272 
	Uses:	t2258 t2259 
	Defs:	t2272 
Oper Node:	80		beqz	's0, L1295
	j		L1296

	Ins:	t103 t105 t106 t2272 
	Outs:	t103 t105 t106 
	Uses:	t2272 
	Defs:	
Oper Node:	81	L1296:

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	82		li		'd0, 0

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 t2203 
	Uses:	
	Defs:	t2203 
Oper Node:	83	L1297:

	Ins:	t103 t105 t106 t2203 
	Outs:	t103 t105 t106 t2203 
	Uses:	
	Defs:	
Move Node:	84		move	'd0, 's0

	Ins:	t103 t105 t106 t2203 
	Outs:	t103 t105 t106 t2205 
	Uses:	t2203 
	Defs:	t2205 
Oper Node:	85		j		L1300


	Ins:	t103 t105 t106 t2205 
	Outs:	t103 t105 t106 t2205 
	Uses:	
	Defs:	
Oper Node:	86	L1295:

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	87		li		'd0, 1

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 t2203 
	Uses:	
	Defs:	t2203 
Oper Node:	88		j		L1297


	Ins:	t103 t105 t106 t2203 
	Outs:	t103 t105 t106 t2203 
	Uses:	
	Defs:	
Oper Node:	89	L1367:

	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	90	L1288:

	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	91		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t108 
	Defs:	
Oper Node:	92		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t106 
	Defs:	
Move Node:	93		move	'd0, 's0

	Ins:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 
	Defs:	t106 
Oper Node:	94		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2279 
	Uses:	t105 
	Defs:	t2279 
Move Node:	95		move	'd0, 's0

	Ins:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2279 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t2279 
	Defs:	t105 
Oper Node:	96		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t122 
	Defs:	
Oper Node:	97		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t123 
	Defs:	
Oper Node:	98		sw		's1, -8('s0)

	Ins:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t125 t126 t127 t128 t129 
	Uses:	t105 t124 
	Defs:	
Oper Node:	99		sw		's1, -12('s0)

	Ins:	t100 t105 t106 t107 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t126 t127 t128 t129 
	Uses:	t105 t125 
	Defs:	
Oper Node:	100		sw		's1, -16('s0)

	Ins:	t100 t105 t106 t107 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t127 t128 t129 
	Uses:	t105 t126 
	Defs:	
Oper Node:	101		sw		's1, -20('s0)

	Ins:	t100 t105 t106 t107 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t128 t129 
	Uses:	t105 t127 
	Defs:	
Oper Node:	102		sw		's1, -24('s0)

	Ins:	t100 t105 t106 t107 t128 t129 
	Outs:	t100 t105 t106 t107 t129 
	Uses:	t105 t128 
	Defs:	
Oper Node:	103		sw		's1, -28('s0)

	Ins:	t100 t105 t106 t107 t129 
	Outs:	t100 t105 t106 t107 
	Uses:	t105 t129 
	Defs:	
Oper Node:	104		sw		's1, -32('s0)

	Ins:	t100 t105 t106 t107 
	Outs:	t100 t105 t106 
	Uses:	t105 t107 
	Defs:	
Oper Node:	105		addi	'd0, 's0, -36

	Ins:	t100 t105 t106 
	Outs:	t100 t106 t2280 
	Uses:	t105 
	Defs:	t2280 
Move Node:	106		move	'd0, 's0

	Ins:	t100 t106 t2280 
	Outs:	t100 t105 t106 
	Uses:	t2280 
	Defs:	t105 
Oper Node:	107	L1307:

	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 
	Uses:	
	Defs:	
Move Node:	108		move	'd0, 's0

	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 t2274 
	Uses:	t106 
	Defs:	t2274 
Oper Node:	109		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2274 
	Outs:	t100 t105 t106 t2274 t2282 
	Uses:	t106 
	Defs:	t2282 
Oper Node:	110		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2274 t2282 
	Outs:	t100 t105 t106 t2274 t2281 
	Uses:	t2282 
	Defs:	t2281 
Oper Node:	111		lw		'd0, -8('s0)

	Ins:	t100 t105 t106 t2274 t2281 
	Outs:	t100 t105 t106 t2273 t2274 
	Uses:	t2281 
	Defs:	t2273 
Oper Node:	112		la		'd0, L1301

	Ins:	t100 t105 t106 t2273 t2274 
	Outs:	t100 t105 t106 t2206 t2273 t2274 
	Uses:	
	Defs:	t2206 
Move Node:	113		move	'd0, 's0

	Ins:	t100 t105 t106 t2206 t2273 t2274 
	Outs:	t100 t105 t106 t2206 t2273 
	Uses:	t2274 
	Defs:	t108 
Move Node:	114		move	'd0, 's0

	Ins:	t100 t105 t106 t2206 t2273 
	Outs:	t100 t105 t106 t2206 
	Uses:	t2273 
	Defs:	t109 
Move Node:	115		move	'd0, 's0

	Ins:	t100 t105 t106 t2206 
	Outs:	t100 t105 t106 
	Uses:	t2206 
	Defs:	t110 
Oper Node:	116	
	Ins:	t100 t105 t106 
	Outs:	t100 t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	117		jal		'j0


	Ins:	t108 t109 t110 
	Outs:	
	Uses:	t108 t109 t110 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	118	
	Ins:	t100 t102 t103 t105 t106 
	Outs:	t100 t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	119		move	'd0, 's0

	Ins:	t100 t102 t103 t105 t106 
	Outs:	t100 t103 t105 t106 t2283 
	Uses:	t102 
	Defs:	t2283 
Move Node:	120		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2283 
	Outs:	t100 t103 t105 t106 t2208 
	Uses:	t2283 
	Defs:	t2208 
Oper Node:	121		beq		's0, 's1, L1304
	j		 L1303

	Ins:	t100 t103 t105 t106 t2208 
	Outs:	t100 t103 t105 t106 
	Uses:	t100 t2208 
	Defs:	t100 
Oper Node:	122	L1304:

	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 
	Uses:	
	Defs:	
Move Node:	123		move	'd0, 's0

	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 t2276 
	Uses:	t106 
	Defs:	t2276 
Oper Node:	124		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2276 
	Outs:	t100 t105 t106 t2276 t2285 
	Uses:	t106 
	Defs:	t2285 
Oper Node:	125		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2276 t2285 
	Outs:	t100 t105 t106 t2276 t2284 
	Uses:	t2285 
	Defs:	t2284 
Oper Node:	126		lw		'd0, -8('s0)

	Ins:	t100 t105 t106 t2276 t2284 
	Outs:	t100 t105 t106 t2275 t2276 
	Uses:	t2284 
	Defs:	t2275 
Oper Node:	127		la		'd0, L1302

	Ins:	t100 t105 t106 t2275 t2276 
	Outs:	t100 t105 t106 t2207 t2275 t2276 
	Uses:	
	Defs:	t2207 
Move Node:	128		move	'd0, 's0

	Ins:	t100 t105 t106 t2207 t2275 t2276 
	Outs:	t100 t105 t106 t2207 t2275 
	Uses:	t2276 
	Defs:	t108 
Move Node:	129		move	'd0, 's0

	Ins:	t100 t105 t106 t2207 t2275 
	Outs:	t100 t105 t106 t2207 
	Uses:	t2275 
	Defs:	t109 
Move Node:	130		move	'd0, 's0

	Ins:	t100 t105 t106 t2207 
	Outs:	t100 t105 t106 
	Uses:	t2207 
	Defs:	t110 
Oper Node:	131	
	Ins:	t100 t105 t106 
	Outs:	t100 t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	132		jal		'j0


	Ins:	t108 t109 t110 
	Outs:	
	Uses:	t108 t109 t110 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	133	
	Ins:	t100 t102 t103 t105 t106 
	Outs:	t100 t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	134		move	'd0, 's0

	Ins:	t100 t102 t103 t105 t106 
	Outs:	t100 t103 t105 t106 t2286 
	Uses:	t102 
	Defs:	t2286 
Move Node:	135		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2286 
	Outs:	t100 t103 t105 t106 t2209 
	Uses:	t2286 
	Defs:	t2209 
Oper Node:	136	L1305:

	Ins:	t100 t103 t105 t106 t2209 
	Outs:	t100 t103 t105 t106 t2209 
	Uses:	
	Defs:	
Move Node:	137		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2209 
	Outs:	t100 t103 t105 t106 t2210 
	Uses:	t2209 
	Defs:	t2210 
Oper Node:	138		beq		's0, 's1, L1306
	j		 L1308

	Ins:	t100 t103 t105 t106 t2210 
	Outs:	t100 t103 t105 t106 
	Uses:	t100 t2210 
	Defs:	t100 
Oper Node:	139	L1306:

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	140		li		'd0, 0

	Ins:	t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 
Oper Node:	141		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2287 
	Uses:	t105 
	Defs:	t2287 
Move Node:	142		move	'd0, 's0

	Ins:	t102 t103 t106 t2287 
	Outs:	t102 t103 t105 t106 
	Uses:	t2287 
	Defs:	t105 
Oper Node:	143		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	144		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	145		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	146		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	147		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	148		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	149		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	150		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	151		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	152		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	153		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	154		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	155	L1303:

	Ins:	t100 t103 t105 t106 
	Outs:	t100 t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	156		li		'd0, 1

	Ins:	t100 t103 t105 t106 
	Outs:	t100 t103 t105 t106 t2209 
	Uses:	
	Defs:	t2209 
Oper Node:	157		j		L1305


	Ins:	t100 t103 t105 t106 t2209 
	Outs:	t100 t103 t105 t106 t2209 
	Uses:	
	Defs:	
Oper Node:	158	L1308:

	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 
	Uses:	
	Defs:	
Oper Node:	159		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 t2290 
	Uses:	t106 
	Defs:	t2290 
Oper Node:	160		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2290 
	Outs:	t100 t105 t106 t2289 
	Uses:	t2290 
	Defs:	t2289 
Oper Node:	161		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t2289 
	Outs:	t100 t105 t106 t2288 
	Uses:	t2289 
	Defs:	t2288 
Move Node:	162		move	'd0, 's0

	Ins:	t100 t105 t106 t2288 
	Outs:	t100 t105 t106 t2278 
	Uses:	t2288 
	Defs:	t2278 
Oper Node:	163	
	Ins:	t100 t105 t106 t2278 
	Outs:	t100 t102 t105 t106 t2278 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	164		jal		'j0


	Ins:	
	Outs:	
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	165	
	Ins:	t100 t102 t105 t106 t2278 
	Outs:	t100 t102 t105 t106 t2278 
	Uses:	
	Defs:	
Move Node:	166		move	'd0, 's0

	Ins:	t100 t102 t105 t106 t2278 
	Outs:	t100 t105 t106 t2278 t2291 
	Uses:	t102 
	Defs:	t2291 
Move Node:	167		move	'd0, 's0

	Ins:	t100 t105 t106 t2278 t2291 
	Outs:	t100 t105 t106 t2277 t2278 
	Uses:	t2291 
	Defs:	t2277 
Oper Node:	168		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t2277 t2278 
	Outs:	t100 t105 t106 
	Uses:	t2277 t2278 
	Defs:	
Oper Node:	169		j		L1307


	Ins:	t100 t105 t106 
	Outs:	t100 t105 t106 
	Uses:	
	Defs:	
Oper Node:	170	L1372:

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	171	L1287:

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	172		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t108 
	Defs:	
Oper Node:	173		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t106 
	Defs:	
Move Node:	174		move	'd0, 's0

	Ins:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 
	Uses:	t109 
	Defs:	t2197 
Move Node:	175		move	'd0, 's0

	Ins:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 
	Uses:	t105 
	Defs:	t106 
Oper Node:	176		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 
	Outs:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 t2300 
	Uses:	t105 
	Defs:	t2300 
Move Node:	177		move	'd0, 's0

	Ins:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 t2300 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 
	Uses:	t2300 
	Defs:	t105 
Oper Node:	178		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2197 
	Uses:	t105 t122 
	Defs:	
Oper Node:	179		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2197 
	Uses:	t105 t123 
	Defs:	
Oper Node:	180		sw		's1, -8('s0)

	Ins:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2197 
	Uses:	t105 t124 
	Defs:	
Oper Node:	181		sw		's1, -12('s0)

	Ins:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t126 t127 t128 t129 t2197 
	Uses:	t105 t125 
	Defs:	
Oper Node:	182		sw		's1, -16('s0)

	Ins:	t100 t105 t106 t107 t126 t127 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t127 t128 t129 t2197 
	Uses:	t105 t126 
	Defs:	
Oper Node:	183		sw		's1, -20('s0)

	Ins:	t100 t105 t106 t107 t127 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t128 t129 t2197 
	Uses:	t105 t127 
	Defs:	
Oper Node:	184		sw		's1, -24('s0)

	Ins:	t100 t105 t106 t107 t128 t129 t2197 
	Outs:	t100 t105 t106 t107 t129 t2197 
	Uses:	t105 t128 
	Defs:	
Oper Node:	185		sw		's1, -28('s0)

	Ins:	t100 t105 t106 t107 t129 t2197 
	Outs:	t100 t105 t106 t107 t2197 
	Uses:	t105 t129 
	Defs:	
Oper Node:	186		sw		's1, -32('s0)

	Ins:	t100 t105 t106 t107 t2197 
	Outs:	t100 t105 t106 t2197 
	Uses:	t105 t107 
	Defs:	
Oper Node:	187		addi	'd0, 's0, -36

	Ins:	t100 t105 t106 t2197 
	Outs:	t100 t106 t2197 t2301 
	Uses:	t105 
	Defs:	t2301 
Move Node:	188		move	'd0, 's0

	Ins:	t100 t106 t2197 t2301 
	Outs:	t100 t105 t106 t2197 
	Uses:	t2301 
	Defs:	t105 
Oper Node:	189		li		'd0, 0

	Ins:	t100 t105 t106 t2197 
	Outs:	t100 t105 t106 t2197 t2198 
	Uses:	
	Defs:	t2198 
Move Node:	190		move	'd0, 's0

	Ins:	t100 t105 t106 t2197 t2198 
	Outs:	t100 t105 t106 t2197 t2198 
	Uses:	t106 
	Defs:	t108 
Oper Node:	191	
	Ins:	t100 t105 t106 t2197 t2198 
	Outs:	t100 t102 t105 t106 t2197 t2198 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	192		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	193	
	Ins:	t100 t102 t105 t106 t2197 t2198 
	Outs:	t100 t102 t105 t106 t2197 t2198 
	Uses:	
	Defs:	
Move Node:	194		move	'd0, 's0

	Ins:	t100 t102 t105 t106 t2197 t2198 
	Outs:	t100 t105 t106 t2197 t2198 
	Uses:	t102 
	Defs:	t2302 
Move Node:	195		move	'd0, 's0

	Ins:	t100 t105 t106 t2197 t2198 
	Outs:	t100 t105 t106 t2198 t2303 
	Uses:	t2197 
	Defs:	t2303 
Move Node:	196		move	'd0, 's0

	Ins:	t100 t105 t106 t2198 t2303 
	Outs:	t100 t105 t106 t2198 t2293 
	Uses:	t2303 
	Defs:	t2293 
Move Node:	197		move	'd0, 's0

	Ins:	t100 t105 t106 t2198 t2293 
	Outs:	t100 t105 t106 t2198 t2293 
	Uses:	t106 
	Defs:	t108 
Oper Node:	198		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2198 t2293 
	Outs:	t100 t105 t106 t2198 t2293 t2304 
	Uses:	t106 
	Defs:	t2304 
Oper Node:	199		lw		'd0, -8('s0)

	Ins:	t100 t105 t106 t2198 t2293 t2304 
	Outs:	t100 t105 t106 t2198 t2293 
	Uses:	t2304 
	Defs:	t109 
Oper Node:	200	
	Ins:	t100 t105 t106 t2198 t2293 
	Outs:	t100 t102 t105 t106 t2198 t2293 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	201		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	202	
	Ins:	t100 t102 t105 t106 t2198 t2293 
	Outs:	t100 t102 t105 t106 t2198 t2293 
	Uses:	
	Defs:	
Move Node:	203		move	'd0, 's0

	Ins:	t100 t102 t105 t106 t2198 t2293 
	Outs:	t100 t105 t106 t2198 t2293 t2305 
	Uses:	t102 
	Defs:	t2305 
Move Node:	204		move	'd0, 's0

	Ins:	t100 t105 t106 t2198 t2293 t2305 
	Outs:	t100 t105 t106 t2198 t2292 t2293 
	Uses:	t2305 
	Defs:	t2292 
Oper Node:	205		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t2198 t2292 t2293 
	Outs:	t100 t105 t106 t2198 
	Uses:	t2292 t2293 
	Defs:	
Oper Node:	206	L1311:

	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t105 t106 t2198 
	Uses:	
	Defs:	
Move Node:	207		move	'd0, 's0

	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t105 t106 t2198 
	Uses:	t106 
	Defs:	t108 
Oper Node:	208		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t105 t106 t2198 t2306 
	Uses:	t106 
	Defs:	t2306 
Oper Node:	209		lw		'd0, -8('s0)

	Ins:	t100 t105 t106 t2198 t2306 
	Outs:	t100 t105 t106 t2198 
	Uses:	t2306 
	Defs:	t109 
Oper Node:	210	
	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t102 t103 t105 t106 t2198 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	211		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	212	
	Ins:	t100 t102 t103 t105 t106 t2198 
	Outs:	t100 t102 t103 t105 t106 t2198 
	Uses:	
	Defs:	
Move Node:	213		move	'd0, 's0

	Ins:	t100 t102 t103 t105 t106 t2198 
	Outs:	t100 t103 t105 t106 t2198 t2307 
	Uses:	t102 
	Defs:	t2307 
Move Node:	214		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2198 t2307 
	Outs:	t100 t103 t105 t106 t2198 t2212 
	Uses:	t2307 
	Defs:	t2212 
Oper Node:	215		beq		's0, 's1, L1309
	j		 L1312

	Ins:	t100 t103 t105 t106 t2198 t2212 
	Outs:	t100 t103 t105 t106 t2198 
	Uses:	t100 t2212 
	Defs:	t100 
Oper Node:	216	L1309:

	Ins:	t103 t105 t106 t2198 
	Outs:	t103 t105 t106 t2198 
	Uses:	
	Defs:	
Move Node:	217		move	'd0, 's0

	Ins:	t103 t105 t106 t2198 
	Outs:	t102 t103 t105 t106 
	Uses:	t2198 
	Defs:	t102 
Oper Node:	218		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2308 
	Uses:	t105 
	Defs:	t2308 
Move Node:	219		move	'd0, 's0

	Ins:	t102 t103 t106 t2308 
	Outs:	t102 t103 t105 t106 
	Uses:	t2308 
	Defs:	t105 
Oper Node:	220		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	221		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	222		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	223		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	224		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	225		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	226		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	227		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	228		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	229		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	230		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	231		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	232	L1312:

	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t105 t106 t2198 
	Uses:	
	Defs:	
Oper Node:	233		li		'd0, 10

	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t105 t106 t2198 t2310 
	Uses:	
	Defs:	t2310 
Oper Node:	234		mult	's0, 's1
	mflo	'd0

	Ins:	t100 t105 t106 t2198 t2310 
	Outs:	t100 t105 t106 t2309 
	Uses:	t2198 t2310 
	Defs:	t2309 
Move Node:	235		move	'd0, 's0

	Ins:	t100 t105 t106 t2309 
	Outs:	t100 t105 t106 t2295 
	Uses:	t2309 
	Defs:	t2295 
Oper Node:	236		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2295 
	Outs:	t100 t105 t106 t2295 t2311 
	Uses:	t106 
	Defs:	t2311 
Oper Node:	237		lw		'd0, -8('s0)

	Ins:	t100 t105 t106 t2295 t2311 
	Outs:	t100 t105 t106 t2295 
	Uses:	t2311 
	Defs:	t108 
Oper Node:	238	
	Ins:	t100 t105 t106 t2295 
	Outs:	t100 t102 t105 t106 t2295 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	239		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	240	
	Ins:	t100 t102 t105 t106 t2295 
	Outs:	t100 t102 t105 t106 t2295 
	Uses:	
	Defs:	
Move Node:	241		move	'd0, 's0

	Ins:	t100 t102 t105 t106 t2295 
	Outs:	t100 t105 t106 t2295 t2312 
	Uses:	t102 
	Defs:	t2312 
Move Node:	242		move	'd0, 's0

	Ins:	t100 t105 t106 t2295 t2312 
	Outs:	t100 t105 t106 t2294 t2295 
	Uses:	t2312 
	Defs:	t2294 
Oper Node:	243		add		'd0, 's0, 's1

	Ins:	t100 t105 t106 t2294 t2295 
	Outs:	t100 t105 t106 t2313 
	Uses:	t2294 t2295 
	Defs:	t2313 
Move Node:	244		move	'd0, 's0

	Ins:	t100 t105 t106 t2313 
	Outs:	t100 t105 t106 t2297 
	Uses:	t2313 
	Defs:	t2297 
Oper Node:	245		la		'd0, L1310

	Ins:	t100 t105 t106 t2297 
	Outs:	t100 t105 t106 t2211 t2297 
	Uses:	
	Defs:	t2211 
Move Node:	246		move	'd0, 's0

	Ins:	t100 t105 t106 t2211 t2297 
	Outs:	t100 t105 t106 t2297 
	Uses:	t2211 
	Defs:	t108 
Oper Node:	247	
	Ins:	t100 t105 t106 t2297 
	Outs:	t100 t102 t105 t106 t2297 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	248		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	249	
	Ins:	t100 t102 t105 t106 t2297 
	Outs:	t100 t102 t105 t106 t2297 
	Uses:	
	Defs:	
Move Node:	250		move	'd0, 's0

	Ins:	t100 t102 t105 t106 t2297 
	Outs:	t100 t105 t106 t2297 t2314 
	Uses:	t102 
	Defs:	t2314 
Move Node:	251		move	'd0, 's0

	Ins:	t100 t105 t106 t2297 t2314 
	Outs:	t100 t105 t106 t2296 t2297 
	Uses:	t2314 
	Defs:	t2296 
Oper Node:	252		sub		'd0, 's0, 's1

	Ins:	t100 t105 t106 t2296 t2297 
	Outs:	t100 t105 t106 t2315 
	Uses:	t2296 t2297 
	Defs:	t2315 
Move Node:	253		move	'd0, 's0

	Ins:	t100 t105 t106 t2315 
	Outs:	t100 t105 t106 t2198 
	Uses:	t2315 
	Defs:	t2198 
Oper Node:	254		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t105 t106 t2198 t2317 
	Uses:	t106 
	Defs:	t2317 
Oper Node:	255		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t2198 t2317 
	Outs:	t100 t105 t106 t2198 t2316 
	Uses:	t2317 
	Defs:	t2316 
Move Node:	256		move	'd0, 's0

	Ins:	t100 t105 t106 t2198 t2316 
	Outs:	t100 t105 t106 t2198 t2299 
	Uses:	t2316 
	Defs:	t2299 
Oper Node:	257	
	Ins:	t100 t105 t106 t2198 t2299 
	Outs:	t100 t102 t105 t106 t2198 t2299 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	258		jal		'j0


	Ins:	
	Outs:	
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	259	
	Ins:	t100 t102 t105 t106 t2198 t2299 
	Outs:	t100 t102 t105 t106 t2198 t2299 
	Uses:	
	Defs:	
Move Node:	260		move	'd0, 's0

	Ins:	t100 t102 t105 t106 t2198 t2299 
	Outs:	t100 t105 t106 t2198 t2299 t2318 
	Uses:	t102 
	Defs:	t2318 
Move Node:	261		move	'd0, 's0

	Ins:	t100 t105 t106 t2198 t2299 t2318 
	Outs:	t100 t105 t106 t2198 t2298 t2299 
	Uses:	t2318 
	Defs:	t2298 
Oper Node:	262		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t2198 t2298 t2299 
	Outs:	t100 t105 t106 t2198 
	Uses:	t2298 t2299 
	Defs:	
Oper Node:	263		j		L1311


	Ins:	t100 t105 t106 t2198 
	Outs:	t100 t105 t106 t2198 
	Uses:	
	Defs:	
Oper Node:	264	L1376:

	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	
	Defs:	
Oper Node:	265	L1316:

	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	
	Defs:	
Oper Node:	266		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t105 t108 
	Defs:	
Oper Node:	267		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t105 t106 
	Defs:	
Move Node:	268		move	'd0, 's0

	Ins:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t105 
	Defs:	t106 
Oper Node:	269		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 t2321 
	Uses:	t105 
	Defs:	t2321 
Move Node:	270		move	'd0, 's0

	Ins:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 t2321 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t2321 
	Defs:	t105 
Oper Node:	271		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t105 t122 
	Defs:	
Oper Node:	272		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t105 t123 
	Defs:	
Oper Node:	273		sw		's1, -8('s0)

	Ins:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2218 
	Uses:	t105 t124 
	Defs:	
Oper Node:	274		sw		's1, -12('s0)

	Ins:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t126 t127 t128 t129 t2218 
	Uses:	t105 t125 
	Defs:	
Oper Node:	275		sw		's1, -16('s0)

	Ins:	t100 t105 t106 t107 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t127 t128 t129 t2218 
	Uses:	t105 t126 
	Defs:	
Oper Node:	276		sw		's1, -20('s0)

	Ins:	t100 t105 t106 t107 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t128 t129 t2218 
	Uses:	t105 t127 
	Defs:	
Oper Node:	277		sw		's1, -24('s0)

	Ins:	t100 t105 t106 t107 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t129 t2218 
	Uses:	t105 t128 
	Defs:	
Oper Node:	278		sw		's1, -28('s0)

	Ins:	t100 t105 t106 t107 t129 t2218 
	Outs:	t100 t105 t106 t107 t2218 
	Uses:	t105 t129 
	Defs:	
Oper Node:	279		sw		's1, -32('s0)

	Ins:	t100 t105 t106 t107 t2218 
	Outs:	t100 t105 t106 t2218 
	Uses:	t105 t107 
	Defs:	
Oper Node:	280		addi	'd0, 's0, -36

	Ins:	t100 t105 t106 t2218 
	Outs:	t100 t106 t2218 t2322 
	Uses:	t105 
	Defs:	t2322 
Move Node:	281		move	'd0, 's0

	Ins:	t100 t106 t2218 t2322 
	Outs:	t100 t105 t106 t2218 
	Uses:	t2322 
	Defs:	t105 
Oper Node:	282		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2218 
	Outs:	t100 t105 t106 t2218 
	Uses:	t106 
	Defs:	t108 
Move Node:	283		move	'd0, 's0

	Ins:	t100 t105 t106 t2218 
	Outs:	t100 t105 t106 
	Uses:	t2218 
	Defs:	t109 
Oper Node:	284	
	Ins:	t100 t105 t106 
	Outs:	t100 t102 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	285		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	286	
	Ins:	t100 t102 t105 t106 
	Outs:	t100 t102 t105 t106 
	Uses:	
	Defs:	
Move Node:	287		move	'd0, 's0

	Ins:	t100 t102 t105 t106 
	Outs:	t100 t105 t106 t2323 
	Uses:	t102 
	Defs:	t2323 
Move Node:	288		move	'd0, 's0

	Ins:	t100 t105 t106 t2323 
	Outs:	t100 t105 t106 t2219 
	Uses:	t2323 
	Defs:	t2219 
Oper Node:	289		li		'd0, 4

	Ins:	t100 t105 t106 t2219 
	Outs:	t100 t105 t106 t2219 
	Uses:	
	Defs:	t108 
Oper Node:	290	
	Ins:	t100 t105 t106 t2219 
	Outs:	t100 t102 t103 t105 t106 t2219 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	291		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	292	
	Ins:	t100 t102 t103 t105 t106 t2219 
	Outs:	t100 t102 t103 t105 t106 t2219 
	Uses:	
	Defs:	
Move Node:	293		move	'd0, 's0

	Ins:	t100 t102 t103 t105 t106 t2219 
	Outs:	t100 t102 t103 t105 t106 t2219 t2324 
	Uses:	t102 
	Defs:	t2324 
Move Node:	294		move	'd0, 's0

	Ins:	t100 t102 t103 t105 t106 t2219 t2324 
	Outs:	t100 t102 t103 t105 t106 t2217 t2219 
	Uses:	t2324 
	Defs:	t2217 
Oper Node:	295		li		'd0, 0

	Ins:	t100 t102 t103 t105 t106 t2217 t2219 
	Outs:	t100 t102 t103 t105 t106 t2217 t2219 t2325 
	Uses:	
	Defs:	t2325 
Oper Node:	296		sw		's1, 0('s0)

	Ins:	t100 t102 t103 t105 t106 t2217 t2219 t2325 
	Outs:	t100 t103 t105 t106 t2217 t2219 
	Uses:	t102 t2325 
	Defs:	
Move Node:	297		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2217 t2219 
	Outs:	t100 t103 t105 t106 t2218 t2219 
	Uses:	t2217 
	Defs:	t2218 
Oper Node:	298		lw		'd0, 0('s0)

	Ins:	t100 t103 t105 t106 t2218 t2219 
	Outs:	t100 t103 t105 t106 t2219 t2221 
	Uses:	t2218 
	Defs:	t2221 
Oper Node:	299		beq		's0, 's1, L1318
	j		 L1317

	Ins:	t100 t103 t105 t106 t2219 t2221 
	Outs:	t103 t105 t106 t2219 
	Uses:	t100 t2221 
	Defs:	t100 
Oper Node:	300	L1318:

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 
	Uses:	
	Defs:	
Oper Node:	301		li		'd0, 0

	Ins:	t103 t105 t106 
	Outs:	t103 t105 t106 t2222 
	Uses:	
	Defs:	t2222 
Oper Node:	302	L1319:

	Ins:	t103 t105 t106 t2222 
	Outs:	t103 t105 t106 t2222 
	Uses:	
	Defs:	
Move Node:	303		move	'd0, 's0

	Ins:	t103 t105 t106 t2222 
	Outs:	t102 t103 t105 t106 
	Uses:	t2222 
	Defs:	t102 
Oper Node:	304		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2326 
	Uses:	t105 
	Defs:	t2326 
Move Node:	305		move	'd0, 's0

	Ins:	t102 t103 t106 t2326 
	Outs:	t102 t103 t105 t106 
	Uses:	t2326 
	Defs:	t105 
Oper Node:	306		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	307		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	308		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	309		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	310		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	311		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	312		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	313		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	314		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	315		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	316		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	317		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	318	L1317:

	Ins:	t105 t106 t2219 
	Outs:	t105 t106 t2219 
	Uses:	
	Defs:	
Oper Node:	319		li		'd0, 8

	Ins:	t105 t106 t2219 
	Outs:	t105 t106 t2219 
	Uses:	
	Defs:	t108 
Oper Node:	320	
	Ins:	t105 t106 t2219 
	Outs:	t102 t105 t106 t2219 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	321		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	322	
	Ins:	t102 t105 t106 t2219 
	Outs:	t102 t105 t106 t2219 
	Uses:	
	Defs:	
Move Node:	323		move	'd0, 's0

	Ins:	t102 t105 t106 t2219 
	Outs:	t102 t105 t106 t2219 t2327 
	Uses:	t102 
	Defs:	t2327 
Move Node:	324		move	'd0, 's0

	Ins:	t102 t105 t106 t2219 t2327 
	Outs:	t102 t105 t106 t2219 t2220 
	Uses:	t2327 
	Defs:	t2220 
Oper Node:	325		sw		's1, 0('s0)

	Ins:	t102 t105 t106 t2219 t2220 
	Outs:	t102 t105 t106 t2220 
	Uses:	t102 t2219 
	Defs:	
Oper Node:	326		addi	'd0, 's0, 4

	Ins:	t102 t105 t106 t2220 
	Outs:	t105 t106 t2220 t2328 
	Uses:	t102 
	Defs:	t2328 
Move Node:	327		move	'd0, 's0

	Ins:	t105 t106 t2220 t2328 
	Outs:	t105 t106 t2220 t2320 
	Uses:	t2328 
	Defs:	t2320 
Oper Node:	328		lw		'd0, 0('s0)

	Ins:	t105 t106 t2220 t2320 
	Outs:	t105 t106 t2220 t2320 
	Uses:	t106 
	Defs:	t108 
Oper Node:	329	
	Ins:	t105 t106 t2220 t2320 
	Outs:	t102 t103 t105 t106 t2220 t2320 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	330		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	331	
	Ins:	t102 t103 t105 t106 t2220 t2320 
	Outs:	t102 t103 t105 t106 t2220 t2320 
	Uses:	
	Defs:	
Move Node:	332		move	'd0, 's0

	Ins:	t102 t103 t105 t106 t2220 t2320 
	Outs:	t103 t105 t106 t2220 t2320 t2329 
	Uses:	t102 
	Defs:	t2329 
Move Node:	333		move	'd0, 's0

	Ins:	t103 t105 t106 t2220 t2320 t2329 
	Outs:	t103 t105 t106 t2220 t2319 t2320 
	Uses:	t2329 
	Defs:	t2319 
Oper Node:	334		sw		's1, 0('s0)

	Ins:	t103 t105 t106 t2220 t2319 t2320 
	Outs:	t103 t105 t106 t2220 
	Uses:	t2319 t2320 
	Defs:	
Move Node:	335		move	'd0, 's0

	Ins:	t103 t105 t106 t2220 
	Outs:	t103 t105 t106 t2222 
	Uses:	t2220 
	Defs:	t2222 
Oper Node:	336		j		L1319


	Ins:	t103 t105 t106 t2222 
	Outs:	t103 t105 t106 t2222 
	Uses:	
	Defs:	
Oper Node:	337	L1383:

	Ins:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	338	L1315:

	Ins:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	339		sw		's1, 0('s0)

	Ins:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t106 t107 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t108 
	Defs:	
Oper Node:	340		sw		's1, -4('s0)

	Ins:	t100 t103 t105 t106 t107 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t107 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t106 
	Defs:	
Move Node:	341		move	'd0, 's0

	Ins:	t100 t103 t105 t107 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t107 t110 t122 t123 t124 t125 t126 t127 t128 t129 t2215 
	Uses:	t109 
	Defs:	t2215 
Move Node:	342		move	'd0, 's0

	Ins:	t100 t103 t105 t107 t110 t122 t123 t124 t125 t126 t127 t128 t129 t2215 
	Outs:	t100 t103 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Uses:	t110 
	Defs:	t2216 
Move Node:	343		move	'd0, 's0

	Ins:	t100 t103 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Uses:	t105 
	Defs:	t106 
Oper Node:	344		addi	'd0, 's0, -8

	Ins:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 t2334 
	Uses:	t105 
	Defs:	t2334 
Move Node:	345		move	'd0, 's0

	Ins:	t100 t103 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 t2334 
	Outs:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Uses:	t2334 
	Defs:	t105 
Oper Node:	346		sw		's1, 0('s0)

	Ins:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Uses:	t105 t122 
	Defs:	
Oper Node:	347		sw		's1, -4('s0)

	Ins:	t100 t103 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Uses:	t105 t123 
	Defs:	
Oper Node:	348		sw		's1, -8('s0)

	Ins:	t100 t103 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t125 t126 t127 t128 t129 t2215 t2216 
	Uses:	t105 t124 
	Defs:	
Oper Node:	349		sw		's1, -12('s0)

	Ins:	t100 t103 t105 t106 t107 t125 t126 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t126 t127 t128 t129 t2215 t2216 
	Uses:	t105 t125 
	Defs:	
Oper Node:	350		sw		's1, -16('s0)

	Ins:	t100 t103 t105 t106 t107 t126 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t127 t128 t129 t2215 t2216 
	Uses:	t105 t126 
	Defs:	
Oper Node:	351		sw		's1, -20('s0)

	Ins:	t100 t103 t105 t106 t107 t127 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t128 t129 t2215 t2216 
	Uses:	t105 t127 
	Defs:	
Oper Node:	352		sw		's1, -24('s0)

	Ins:	t100 t103 t105 t106 t107 t128 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t129 t2215 t2216 
	Uses:	t105 t128 
	Defs:	
Oper Node:	353		sw		's1, -28('s0)

	Ins:	t100 t103 t105 t106 t107 t129 t2215 t2216 
	Outs:	t100 t103 t105 t106 t107 t2215 t2216 
	Uses:	t105 t129 
	Defs:	
Oper Node:	354		sw		's1, -32('s0)

	Ins:	t100 t103 t105 t106 t107 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	t105 t107 
	Defs:	
Oper Node:	355		addi	'd0, 's0, -36

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t106 t2215 t2216 t2335 
	Uses:	t105 
	Defs:	t2335 
Move Node:	356		move	'd0, 's0

	Ins:	t100 t103 t106 t2215 t2216 t2335 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	t2335 
	Defs:	t105 
Oper Node:	357		beq		's0, 's1, L1320
	j		L1321

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	t100 t2215 
	Defs:	t100 
Oper Node:	358	L1321:

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	359		li		'd0, 0

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2223 
	Uses:	
	Defs:	t2223 
Oper Node:	360	L1322:

	Ins:	t100 t103 t105 t106 t2215 t2216 t2223 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2223 
	Uses:	
	Defs:	
Move Node:	361		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2215 t2216 t2223 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2232 
	Uses:	t2223 
	Defs:	t2232 
Oper Node:	362		beq		's0, 's1, L1336
	j		 L1335

	Ins:	t100 t103 t105 t106 t2215 t2216 t2232 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	t100 t2232 
	Defs:	t100 
Oper Node:	363	L1336:

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	364		beq		's0, 's1, L1323
	j		L1324

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	t100 t2216 
	Defs:	t100 
Oper Node:	365	L1324:

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	366		li		'd0, 0

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2224 
	Uses:	
	Defs:	t2224 
Oper Node:	367	L1325:

	Ins:	t100 t103 t105 t106 t2215 t2216 t2224 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2224 
	Uses:	
	Defs:	
Move Node:	368		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2215 t2216 t2224 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2230 
	Uses:	t2224 
	Defs:	t2230 
Oper Node:	369		beq		's0, 's1, L1333
	j		 L1332

	Ins:	t100 t103 t105 t106 t2215 t2216 t2230 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	t100 t2230 
	Defs:	t100 
Oper Node:	370	L1333:

	Ins:	t100 t105 t106 t2215 t2216 
	Outs:	t100 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	371		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2215 t2216 
	Outs:	t100 t105 t106 t2215 t2216 t2337 
	Uses:	t2215 
	Defs:	t2337 
Oper Node:	372		lw		'd0, 0('s0)

	Ins:	t100 t105 t106 t2215 t2216 t2337 
	Outs:	t100 t105 t106 t2215 t2216 t2337 t2338 
	Uses:	t2216 
	Defs:	t2338 
Oper Node:	373		slt		'd0, 's0, 's1

	Ins:	t100 t105 t106 t2215 t2216 t2337 t2338 
	Outs:	t100 t105 t106 t2215 t2216 
	Uses:	t2337 t2338 
	Defs:	t2336 
Oper Node:	374		beqz	'd0, L1327
	j		L1326

	Ins:	t100 t105 t106 t2215 t2216 
	Outs:	t100 t105 t106 t2215 t2216 
	Uses:	
	Defs:	t2336 
Oper Node:	375	L1327:

	Ins:	t100 t105 t106 t2215 t2216 
	Outs:	t100 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	376		li		'd0, 0

	Ins:	t100 t105 t106 t2215 t2216 
	Outs:	t100 t105 t106 t2215 t2216 t2225 
	Uses:	
	Defs:	t2225 
Oper Node:	377	L1328:

	Ins:	t100 t105 t106 t2215 t2216 t2225 
	Outs:	t100 t105 t106 t2215 t2216 t2225 
	Uses:	
	Defs:	
Move Node:	378		move	'd0, 's0

	Ins:	t100 t105 t106 t2215 t2216 t2225 
	Outs:	t100 t105 t106 t2215 t2216 t2228 
	Uses:	t2225 
	Defs:	t2228 
Oper Node:	379		beq		's0, 's1, L1330
	j		 L1329

	Ins:	t100 t105 t106 t2215 t2216 t2228 
	Outs:	t105 t106 t2215 t2216 
	Uses:	t100 t2228 
	Defs:	t100 
Oper Node:	380	L1330:

	Ins:	t105 t106 t2215 t2216 
	Outs:	t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	381		li		'd0, 8

	Ins:	t105 t106 t2215 t2216 
	Outs:	t105 t106 t2215 t2216 
	Uses:	
	Defs:	t108 
Oper Node:	382	
	Ins:	t105 t106 t2215 t2216 
	Outs:	t102 t105 t106 t2215 t2216 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	383		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	384	
	Ins:	t102 t105 t106 t2215 t2216 
	Outs:	t102 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Move Node:	385		move	'd0, 's0

	Ins:	t102 t105 t106 t2215 t2216 
	Outs:	t102 t105 t106 t2215 t2216 t2339 
	Uses:	t102 
	Defs:	t2339 
Move Node:	386		move	'd0, 's0

	Ins:	t102 t105 t106 t2215 t2216 t2339 
	Outs:	t102 t105 t106 t2215 t2216 t2227 
	Uses:	t2339 
	Defs:	t2227 
Oper Node:	387		lw		'd0, 0('s0)

	Ins:	t102 t105 t106 t2215 t2216 t2227 
	Outs:	t102 t105 t106 t2215 t2216 t2227 t2340 
	Uses:	t2216 
	Defs:	t2340 
Oper Node:	388		sw		's1, 0('s0)

	Ins:	t102 t105 t106 t2215 t2216 t2227 t2340 
	Outs:	t102 t105 t106 t2215 t2216 t2227 
	Uses:	t102 t2340 
	Defs:	
Oper Node:	389		addi	'd0, 's0, 4

	Ins:	t102 t105 t106 t2215 t2216 t2227 
	Outs:	t105 t106 t2215 t2216 t2227 t2341 
	Uses:	t102 
	Defs:	t2341 
Move Node:	390		move	'd0, 's0

	Ins:	t105 t106 t2215 t2216 t2227 t2341 
	Outs:	t105 t106 t2215 t2216 t2227 t2333 
	Uses:	t2341 
	Defs:	t2333 
Oper Node:	391		lw		'd0, 0('s0)

	Ins:	t105 t106 t2215 t2216 t2227 t2333 
	Outs:	t105 t106 t2215 t2216 t2227 t2333 
	Uses:	t106 
	Defs:	t108 
Move Node:	392		move	'd0, 's0

	Ins:	t105 t106 t2215 t2216 t2227 t2333 
	Outs:	t105 t106 t2216 t2227 t2333 
	Uses:	t2215 
	Defs:	t109 
Oper Node:	393		lw		'd0, 4('s0)

	Ins:	t105 t106 t2216 t2227 t2333 
	Outs:	t105 t106 t2227 t2333 
	Uses:	t2216 
	Defs:	t110 
Oper Node:	394	
	Ins:	t105 t106 t2227 t2333 
	Outs:	t102 t103 t105 t106 t2227 t2333 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	395		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 t110 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	396	
	Ins:	t102 t103 t105 t106 t2227 t2333 
	Outs:	t102 t103 t105 t106 t2227 t2333 
	Uses:	
	Defs:	
Move Node:	397		move	'd0, 's0

	Ins:	t102 t103 t105 t106 t2227 t2333 
	Outs:	t103 t105 t106 t2227 t2333 t2342 
	Uses:	t102 
	Defs:	t2342 
Move Node:	398		move	'd0, 's0

	Ins:	t103 t105 t106 t2227 t2333 t2342 
	Outs:	t103 t105 t106 t2227 t2332 t2333 
	Uses:	t2342 
	Defs:	t2332 
Oper Node:	399		sw		's1, 0('s0)

	Ins:	t103 t105 t106 t2227 t2332 t2333 
	Outs:	t103 t105 t106 t2227 
	Uses:	t2332 t2333 
	Defs:	
Move Node:	400		move	'd0, 's0

	Ins:	t103 t105 t106 t2227 
	Outs:	t103 t105 t106 t2229 
	Uses:	t2227 
	Defs:	t2229 
Oper Node:	401	L1331:

	Ins:	t103 t105 t106 t2229 
	Outs:	t103 t105 t106 t2229 
	Uses:	
	Defs:	
Move Node:	402		move	'd0, 's0

	Ins:	t103 t105 t106 t2229 
	Outs:	t103 t105 t106 t2231 
	Uses:	t2229 
	Defs:	t2231 
Oper Node:	403	L1334:

	Ins:	t103 t105 t106 t2231 
	Outs:	t103 t105 t106 t2231 
	Uses:	
	Defs:	
Move Node:	404		move	'd0, 's0

	Ins:	t103 t105 t106 t2231 
	Outs:	t103 t105 t106 t2233 
	Uses:	t2231 
	Defs:	t2233 
Oper Node:	405	L1337:

	Ins:	t103 t105 t106 t2233 
	Outs:	t103 t105 t106 t2233 
	Uses:	
	Defs:	
Move Node:	406		move	'd0, 's0

	Ins:	t103 t105 t106 t2233 
	Outs:	t102 t103 t105 t106 
	Uses:	t2233 
	Defs:	t102 
Oper Node:	407		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2343 
	Uses:	t105 
	Defs:	t2343 
Move Node:	408		move	'd0, 's0

	Ins:	t102 t103 t106 t2343 
	Outs:	t102 t103 t105 t106 
	Uses:	t2343 
	Defs:	t105 
Oper Node:	409		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	410		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	411		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	412		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	413		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	414		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	415		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	416		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	417		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	418		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	419		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	420		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	421	L1320:

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	422		li		'd0, 1

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2223 
	Uses:	
	Defs:	t2223 
Oper Node:	423		j		L1322


	Ins:	t100 t103 t105 t106 t2215 t2216 t2223 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2223 
	Uses:	
	Defs:	
Oper Node:	424	L1335:

	Ins:	t103 t105 t106 t2216 
	Outs:	t103 t105 t106 t2216 
	Uses:	
	Defs:	
Move Node:	425		move	'd0, 's0

	Ins:	t103 t105 t106 t2216 
	Outs:	t103 t105 t106 t2233 
	Uses:	t2216 
	Defs:	t2233 
Oper Node:	426		j		L1337


	Ins:	t103 t105 t106 t2233 
	Outs:	t103 t105 t106 t2233 
	Uses:	
	Defs:	
Oper Node:	427	L1323:

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	428		li		'd0, 1

	Ins:	t100 t103 t105 t106 t2215 t2216 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2224 
	Uses:	
	Defs:	t2224 
Oper Node:	429		j		L1325


	Ins:	t100 t103 t105 t106 t2215 t2216 t2224 
	Outs:	t100 t103 t105 t106 t2215 t2216 t2224 
	Uses:	
	Defs:	
Oper Node:	430	L1332:

	Ins:	t103 t105 t106 t2215 
	Outs:	t103 t105 t106 t2215 
	Uses:	
	Defs:	
Move Node:	431		move	'd0, 's0

	Ins:	t103 t105 t106 t2215 
	Outs:	t103 t105 t106 t2231 
	Uses:	t2215 
	Defs:	t2231 
Oper Node:	432		j		L1334


	Ins:	t103 t105 t106 t2231 
	Outs:	t103 t105 t106 t2231 
	Uses:	
	Defs:	
Oper Node:	433	L1326:

	Ins:	t100 t105 t106 t2215 t2216 
	Outs:	t100 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	434		li		'd0, 1

	Ins:	t100 t105 t106 t2215 t2216 
	Outs:	t100 t105 t106 t2215 t2216 t2225 
	Uses:	
	Defs:	t2225 
Oper Node:	435		j		L1328


	Ins:	t100 t105 t106 t2215 t2216 t2225 
	Outs:	t100 t105 t106 t2215 t2216 t2225 
	Uses:	
	Defs:	
Oper Node:	436	L1329:

	Ins:	t105 t106 t2215 t2216 
	Outs:	t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Oper Node:	437		li		'd0, 8

	Ins:	t105 t106 t2215 t2216 
	Outs:	t105 t106 t2215 t2216 
	Uses:	
	Defs:	t108 
Oper Node:	438	
	Ins:	t105 t106 t2215 t2216 
	Outs:	t102 t105 t106 t2215 t2216 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	439		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	440	
	Ins:	t102 t105 t106 t2215 t2216 
	Outs:	t102 t105 t106 t2215 t2216 
	Uses:	
	Defs:	
Move Node:	441		move	'd0, 's0

	Ins:	t102 t105 t106 t2215 t2216 
	Outs:	t102 t105 t106 t2215 t2216 t2344 
	Uses:	t102 
	Defs:	t2344 
Move Node:	442		move	'd0, 's0

	Ins:	t102 t105 t106 t2215 t2216 t2344 
	Outs:	t102 t105 t106 t2215 t2216 t2226 
	Uses:	t2344 
	Defs:	t2226 
Oper Node:	443		lw		'd0, 0('s0)

	Ins:	t102 t105 t106 t2215 t2216 t2226 
	Outs:	t102 t105 t106 t2215 t2216 t2226 t2345 
	Uses:	t2215 
	Defs:	t2345 
Oper Node:	444		sw		's1, 0('s0)

	Ins:	t102 t105 t106 t2215 t2216 t2226 t2345 
	Outs:	t102 t105 t106 t2215 t2216 t2226 
	Uses:	t102 t2345 
	Defs:	
Oper Node:	445		addi	'd0, 's0, 4

	Ins:	t102 t105 t106 t2215 t2216 t2226 
	Outs:	t105 t106 t2215 t2216 t2226 t2346 
	Uses:	t102 
	Defs:	t2346 
Move Node:	446		move	'd0, 's0

	Ins:	t105 t106 t2215 t2216 t2226 t2346 
	Outs:	t105 t106 t2215 t2216 t2226 t2331 
	Uses:	t2346 
	Defs:	t2331 
Oper Node:	447		lw		'd0, 0('s0)

	Ins:	t105 t106 t2215 t2216 t2226 t2331 
	Outs:	t105 t106 t2215 t2216 t2226 t2331 
	Uses:	t106 
	Defs:	t108 
Oper Node:	448		lw		'd0, 4('s0)

	Ins:	t105 t106 t2215 t2216 t2226 t2331 
	Outs:	t105 t106 t2216 t2226 t2331 
	Uses:	t2215 
	Defs:	t109 
Move Node:	449		move	'd0, 's0

	Ins:	t105 t106 t2216 t2226 t2331 
	Outs:	t105 t106 t2226 t2331 
	Uses:	t2216 
	Defs:	t110 
Oper Node:	450	
	Ins:	t105 t106 t2226 t2331 
	Outs:	t102 t103 t105 t106 t2226 t2331 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	451		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 t110 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	452	
	Ins:	t102 t103 t105 t106 t2226 t2331 
	Outs:	t102 t103 t105 t106 t2226 t2331 
	Uses:	
	Defs:	
Move Node:	453		move	'd0, 's0

	Ins:	t102 t103 t105 t106 t2226 t2331 
	Outs:	t103 t105 t106 t2226 t2331 t2347 
	Uses:	t102 
	Defs:	t2347 
Move Node:	454		move	'd0, 's0

	Ins:	t103 t105 t106 t2226 t2331 t2347 
	Outs:	t103 t105 t106 t2226 t2330 t2331 
	Uses:	t2347 
	Defs:	t2330 
Oper Node:	455		sw		's1, 0('s0)

	Ins:	t103 t105 t106 t2226 t2330 t2331 
	Outs:	t103 t105 t106 t2226 
	Uses:	t2330 t2331 
	Defs:	
Move Node:	456		move	'd0, 's0

	Ins:	t103 t105 t106 t2226 
	Outs:	t103 t105 t106 t2229 
	Uses:	t2226 
	Defs:	t2229 
Oper Node:	457		j		L1331


	Ins:	t103 t105 t106 t2229 
	Outs:	t103 t105 t106 t2229 
	Uses:	
	Defs:	
Oper Node:	458	L1388:

	Ins:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Uses:	
	Defs:	
Oper Node:	459	L1338:

	Ins:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Uses:	
	Defs:	
Oper Node:	460		sw		's1, 0('s0)

	Ins:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Uses:	t105 t108 
	Defs:	
Oper Node:	461		sw		's1, -4('s0)

	Ins:	t100 t103 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Uses:	t105 t106 
	Defs:	
Move Node:	462		move	'd0, 's0

	Ins:	t100 t103 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Uses:	t109 
	Defs:	t2234 
Move Node:	463		move	'd0, 's0

	Ins:	t100 t103 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Uses:	t105 
	Defs:	t106 
Oper Node:	464		addi	'd0, 's0, -8

	Ins:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 t2351 
	Uses:	t105 
	Defs:	t2351 
Move Node:	465		move	'd0, 's0

	Ins:	t100 t103 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 t2351 
	Outs:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Uses:	t2351 
	Defs:	t105 
Oper Node:	466		sw		's1, 0('s0)

	Ins:	t100 t103 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Uses:	t105 t122 
	Defs:	
Oper Node:	467		sw		's1, -4('s0)

	Ins:	t100 t103 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Uses:	t105 t123 
	Defs:	
Oper Node:	468		sw		's1, -8('s0)

	Ins:	t100 t103 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t125 t126 t127 t128 t129 t2234 t2238 
	Uses:	t105 t124 
	Defs:	
Oper Node:	469		sw		's1, -12('s0)

	Ins:	t100 t103 t105 t106 t107 t125 t126 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t126 t127 t128 t129 t2234 t2238 
	Uses:	t105 t125 
	Defs:	
Oper Node:	470		sw		's1, -16('s0)

	Ins:	t100 t103 t105 t106 t107 t126 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t127 t128 t129 t2234 t2238 
	Uses:	t105 t126 
	Defs:	
Oper Node:	471		sw		's1, -20('s0)

	Ins:	t100 t103 t105 t106 t107 t127 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t128 t129 t2234 t2238 
	Uses:	t105 t127 
	Defs:	
Oper Node:	472		sw		's1, -24('s0)

	Ins:	t100 t103 t105 t106 t107 t128 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t129 t2234 t2238 
	Uses:	t105 t128 
	Defs:	
Oper Node:	473		sw		's1, -28('s0)

	Ins:	t100 t103 t105 t106 t107 t129 t2234 t2238 
	Outs:	t100 t103 t105 t106 t107 t2234 t2238 
	Uses:	t105 t129 
	Defs:	
Oper Node:	474		sw		's1, -32('s0)

	Ins:	t100 t103 t105 t106 t107 t2234 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2238 
	Uses:	t105 t107 
	Defs:	
Oper Node:	475		addi	'd0, 's0, -36

	Ins:	t100 t103 t105 t106 t2234 t2238 
	Outs:	t100 t103 t106 t2234 t2238 t2352 
	Uses:	t105 
	Defs:	t2352 
Move Node:	476		move	'd0, 's0

	Ins:	t100 t103 t106 t2234 t2238 t2352 
	Outs:	t100 t103 t105 t106 t2234 t2238 
	Uses:	t2352 
	Defs:	t105 
Oper Node:	477		slt		'd0, 's1, 's0
	Ins:	t100 t103 t105 t106 t2234 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2238 t2353 
	Uses:	t100 t2234 
	Defs:	t100 t2353 
Oper Node:	478		beqz	's0, L1340
	j		L1339

	Ins:	t100 t103 t105 t106 t2234 t2238 t2353 
	Outs:	t100 t103 t105 t106 t2234 t2238 
	Uses:	t2353 
	Defs:	
Oper Node:	479	L1340:

	Ins:	t100 t103 t105 t106 t2234 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2238 
	Uses:	
	Defs:	
Oper Node:	480		li		'd0, 0

	Ins:	t100 t103 t105 t106 t2234 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2235 t2238 
	Uses:	
	Defs:	t2235 
Oper Node:	481	L1341:

	Ins:	t100 t103 t105 t106 t2234 t2235 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2235 t2238 
	Uses:	
	Defs:	
Move Node:	482		move	'd0, 's0

	Ins:	t100 t103 t105 t106 t2234 t2235 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2237 t2238 
	Uses:	t2235 
	Defs:	t2237 
Oper Node:	483		beq		's0, 's1, L1344
	j		 L1343

	Ins:	t100 t103 t105 t106 t2234 t2237 t2238 
	Outs:	t103 t105 t106 t2234 t2238 
	Uses:	t100 t2237 
	Defs:	t100 
Oper Node:	484	L1344:

	Ins:	t103 t105 t106 t2238 
	Outs:	t103 t105 t106 t2238 
	Uses:	
	Defs:	
Move Node:	485		move	'd0, 's0

	Ins:	t103 t105 t106 t2238 
	Outs:	t102 t103 t105 t106 
	Uses:	t2238 
	Defs:	t102 
Oper Node:	486		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2354 
	Uses:	t105 
	Defs:	t2354 
Move Node:	487		move	'd0, 's0

	Ins:	t102 t103 t106 t2354 
	Outs:	t102 t103 t105 t106 
	Uses:	t2354 
	Defs:	t105 
Oper Node:	488		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	489		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	490		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	491		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	492		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	493		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	494		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	495		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	496		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	497		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	498		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	499		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	500	L1339:

	Ins:	t100 t103 t105 t106 t2234 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2238 
	Uses:	
	Defs:	
Oper Node:	501		li		'd0, 1

	Ins:	t100 t103 t105 t106 t2234 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2235 t2238 
	Uses:	
	Defs:	t2235 
Oper Node:	502		j		L1341


	Ins:	t100 t103 t105 t106 t2234 t2235 t2238 
	Outs:	t100 t103 t105 t106 t2234 t2235 t2238 
	Uses:	
	Defs:	
Oper Node:	503	L1343:

	Ins:	t105 t106 t2234 
	Outs:	t105 t106 t2234 
	Uses:	
	Defs:	
Oper Node:	504		lw		'd0, 0('s0)

	Ins:	t105 t106 t2234 
	Outs:	t105 t106 t2234 
	Uses:	t106 
	Defs:	t108 
Oper Node:	505		li		'd0, 10

	Ins:	t105 t106 t2234 
	Outs:	t105 t106 t2234 t2356 
	Uses:	
	Defs:	t2356 
Oper Node:	506		div		's0, 's1
	mflo	'd0

	Ins:	t105 t106 t2234 t2356 
	Outs:	t105 t106 t2234 t2355 
	Uses:	t2234 t2356 
	Defs:	t100 t2355 
Move Node:	507		move	'd0, 's0

	Ins:	t105 t106 t2234 t2355 
	Outs:	t105 t106 t2234 
	Uses:	t2355 
	Defs:	t109 
Oper Node:	508	
	Ins:	t105 t106 t2234 
	Outs:	t102 t105 t106 t2234 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	509		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	510	
	Ins:	t102 t105 t106 t2234 
	Outs:	t102 t105 t106 t2234 
	Uses:	
	Defs:	
Move Node:	511		move	'd0, 's0

	Ins:	t102 t105 t106 t2234 
	Outs:	t105 t106 t2234 
	Uses:	t102 
	Defs:	t2357 
Oper Node:	512		li		'd0, 10

	Ins:	t105 t106 t2234 
	Outs:	t105 t106 t2234 t2361 
	Uses:	
	Defs:	t2361 
Oper Node:	513		div		's0, 's1
	mflo	'd0

	Ins:	t105 t106 t2234 t2361 
	Outs:	t105 t106 t2234 t2360 
	Uses:	t2234 t2361 
	Defs:	t100 t2360 
Oper Node:	514		li		'd0, 10

	Ins:	t105 t106 t2234 t2360 
	Outs:	t105 t106 t2234 t2360 t2362 
	Uses:	
	Defs:	t2362 
Oper Node:	515		mult	's0, 's1
	mflo	'd0

	Ins:	t105 t106 t2234 t2360 t2362 
	Outs:	t105 t106 t2234 t2359 
	Uses:	t2360 t2362 
	Defs:	t2359 
Oper Node:	516		sub		'd0, 's0, 's1

	Ins:	t105 t106 t2234 t2359 
	Outs:	t105 t106 t2358 
	Uses:	t2234 t2359 
	Defs:	t2358 
Move Node:	517		move	'd0, 's0

	Ins:	t105 t106 t2358 
	Outs:	t105 t106 t2350 
	Uses:	t2358 
	Defs:	t2350 
Oper Node:	518		la		'd0, L1342

	Ins:	t105 t106 t2350 
	Outs:	t105 t106 t2236 t2350 
	Uses:	
	Defs:	t2236 
Move Node:	519		move	'd0, 's0

	Ins:	t105 t106 t2236 t2350 
	Outs:	t105 t106 t2350 
	Uses:	t2236 
	Defs:	t108 
Oper Node:	520	
	Ins:	t105 t106 t2350 
	Outs:	t102 t105 t106 t2350 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	521		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	522	
	Ins:	t102 t105 t106 t2350 
	Outs:	t102 t105 t106 t2350 
	Uses:	
	Defs:	
Move Node:	523		move	'd0, 's0

	Ins:	t102 t105 t106 t2350 
	Outs:	t105 t106 t2350 t2363 
	Uses:	t102 
	Defs:	t2363 
Move Node:	524		move	'd0, 's0

	Ins:	t105 t106 t2350 t2363 
	Outs:	t105 t106 t2349 t2350 
	Uses:	t2363 
	Defs:	t2349 
Oper Node:	525		add		'd0, 's0, 's1

	Ins:	t105 t106 t2349 t2350 
	Outs:	t105 t106 t2364 
	Uses:	t2349 t2350 
	Defs:	t2364 
Move Node:	526		move	'd0, 's0

	Ins:	t105 t106 t2364 
	Outs:	t105 t106 
	Uses:	t2364 
	Defs:	t108 
Oper Node:	527	
	Ins:	t105 t106 
	Outs:	t102 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	528		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	529	
	Ins:	t102 t105 t106 
	Outs:	t102 t105 t106 
	Uses:	
	Defs:	
Move Node:	530		move	'd0, 's0

	Ins:	t102 t105 t106 
	Outs:	t105 t106 t2365 
	Uses:	t102 
	Defs:	t2365 
Move Node:	531		move	'd0, 's0

	Ins:	t105 t106 t2365 
	Outs:	t105 t106 t2348 
	Uses:	t2365 
	Defs:	t2348 
Move Node:	532		move	'd0, 's0

	Ins:	t105 t106 t2348 
	Outs:	t105 t106 
	Uses:	t2348 
	Defs:	t108 
Oper Node:	533	
	Ins:	t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	534		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	535	
	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	536		move	'd0, 's0

	Ins:	t102 t103 t105 t106 
	Outs:	t103 t105 t106 t2366 
	Uses:	t102 
	Defs:	t2366 
Move Node:	537		move	'd0, 's0

	Ins:	t103 t105 t106 t2366 
	Outs:	t103 t105 t106 t2238 
	Uses:	t2366 
	Defs:	t2238 
Oper Node:	538		j		L1344


	Ins:	t103 t105 t106 t2238 
	Outs:	t103 t105 t106 t2238 
	Uses:	
	Defs:	
Oper Node:	539	L1393:

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	540	L1314:

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	541		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t108 
	Defs:	
Oper Node:	542		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t106 
	Defs:	
Move Node:	543		move	'd0, 's0

	Ins:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 
	Uses:	t109 
	Defs:	t2214 
Move Node:	544		move	'd0, 's0

	Ins:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 
	Uses:	t105 
	Defs:	t106 
Oper Node:	545		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 
	Outs:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 t2367 
	Uses:	t105 
	Defs:	t2367 
Move Node:	546		move	'd0, 's0

	Ins:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 t2367 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 
	Uses:	t2367 
	Defs:	t105 
Oper Node:	547		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2214 
	Uses:	t105 t122 
	Defs:	
Oper Node:	548		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2214 
	Uses:	t105 t123 
	Defs:	
Oper Node:	549		sw		's1, -8('s0)

	Ins:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2214 
	Uses:	t105 t124 
	Defs:	
Oper Node:	550		sw		's1, -12('s0)

	Ins:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t126 t127 t128 t129 t2214 
	Uses:	t105 t125 
	Defs:	
Oper Node:	551		sw		's1, -16('s0)

	Ins:	t100 t105 t106 t107 t126 t127 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t127 t128 t129 t2214 
	Uses:	t105 t126 
	Defs:	
Oper Node:	552		sw		's1, -20('s0)

	Ins:	t100 t105 t106 t107 t127 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t128 t129 t2214 
	Uses:	t105 t127 
	Defs:	
Oper Node:	553		sw		's1, -24('s0)

	Ins:	t100 t105 t106 t107 t128 t129 t2214 
	Outs:	t100 t105 t106 t107 t129 t2214 
	Uses:	t105 t128 
	Defs:	
Oper Node:	554		sw		's1, -28('s0)

	Ins:	t100 t105 t106 t107 t129 t2214 
	Outs:	t100 t105 t106 t107 t2214 
	Uses:	t105 t129 
	Defs:	
Oper Node:	555		sw		's1, -32('s0)

	Ins:	t100 t105 t106 t107 t2214 
	Outs:	t100 t105 t106 t2214 
	Uses:	t105 t107 
	Defs:	
Oper Node:	556		addi	'd0, 's0, -36

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t106 t2214 t2368 
	Uses:	t105 
	Defs:	t2368 
Move Node:	557		move	'd0, 's0

	Ins:	t100 t106 t2214 t2368 
	Outs:	t100 t105 t106 t2214 
	Uses:	t2368 
	Defs:	t105 
Oper Node:	558		slt		'd0, 's0, 's1

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 t2369 
	Uses:	t100 t2214 
	Defs:	t100 t2369 
Oper Node:	559		beqz	's0, L1346
	j		L1345

	Ins:	t100 t105 t106 t2214 t2369 
	Outs:	t100 t105 t106 t2214 
	Uses:	t2369 
	Defs:	
Oper Node:	560	L1346:

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 
	Uses:	
	Defs:	
Oper Node:	561		li		'd0, 0

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 t2239 
	Uses:	
	Defs:	t2239 
Oper Node:	562	L1347:

	Ins:	t100 t105 t106 t2214 t2239 
	Outs:	t100 t105 t106 t2214 t2239 
	Uses:	
	Defs:	
Move Node:	563		move	'd0, 's0

	Ins:	t100 t105 t106 t2214 t2239 
	Outs:	t100 t105 t106 t2214 t2245 
	Uses:	t2239 
	Defs:	t2245 
Oper Node:	564		beq		's0, 's1, L1357
	j		 L1356

	Ins:	t100 t105 t106 t2214 t2245 
	Outs:	t100 t105 t106 t2214 
	Uses:	t100 t2245 
	Defs:	t100 
Oper Node:	565	L1357:

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 
	Uses:	
	Defs:	
Oper Node:	566		slt		'd0, 's1, 's0
	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 t2370 
	Uses:	t100 t2214 
	Defs:	t100 t2370 
Oper Node:	567		beqz	's0, L1350
	j		L1349

	Ins:	t100 t105 t106 t2214 t2370 
	Outs:	t100 t105 t106 t2214 
	Uses:	t2370 
	Defs:	
Oper Node:	568	L1350:

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 
	Uses:	
	Defs:	
Oper Node:	569		li		'd0, 0

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 t2241 
	Uses:	
	Defs:	t2241 
Oper Node:	570	L1351:

	Ins:	t100 t105 t106 t2214 t2241 
	Outs:	t100 t105 t106 t2214 t2241 
	Uses:	
	Defs:	
Move Node:	571		move	'd0, 's0

	Ins:	t100 t105 t106 t2214 t2241 
	Outs:	t100 t105 t106 t2214 t2243 
	Uses:	t2241 
	Defs:	t2243 
Oper Node:	572		beq		's0, 's1, L1354
	j		 L1353

	Ins:	t100 t105 t106 t2214 t2243 
	Outs:	t105 t106 t2214 
	Uses:	t100 t2243 
	Defs:	t100 
Oper Node:	573	L1354:

	Ins:	t105 t106 
	Outs:	t105 t106 
	Uses:	
	Defs:	
Oper Node:	574		la		'd0, L1352

	Ins:	t105 t106 
	Outs:	t105 t106 t2242 
	Uses:	
	Defs:	t2242 
Move Node:	575		move	'd0, 's0

	Ins:	t105 t106 t2242 
	Outs:	t105 t106 
	Uses:	t2242 
	Defs:	t108 
Oper Node:	576	
	Ins:	t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	577		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	578	
	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	579		move	'd0, 's0

	Ins:	t102 t103 t105 t106 
	Outs:	t103 t105 t106 t2371 
	Uses:	t102 
	Defs:	t2371 
Move Node:	580		move	'd0, 's0

	Ins:	t103 t105 t106 t2371 
	Outs:	t103 t105 t106 t2244 
	Uses:	t2371 
	Defs:	t2244 
Oper Node:	581	L1355:

	Ins:	t103 t105 t106 t2244 
	Outs:	t103 t105 t106 t2244 
	Uses:	
	Defs:	
Move Node:	582		move	'd0, 's0

	Ins:	t103 t105 t106 t2244 
	Outs:	t103 t105 t106 t2246 
	Uses:	t2244 
	Defs:	t2246 
Oper Node:	583	L1358:

	Ins:	t103 t105 t106 t2246 
	Outs:	t103 t105 t106 t2246 
	Uses:	
	Defs:	
Move Node:	584		move	'd0, 's0

	Ins:	t103 t105 t106 t2246 
	Outs:	t102 t103 t105 t106 
	Uses:	t2246 
	Defs:	t102 
Oper Node:	585		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2372 
	Uses:	t105 
	Defs:	t2372 
Move Node:	586		move	'd0, 's0

	Ins:	t102 t103 t106 t2372 
	Outs:	t102 t103 t105 t106 
	Uses:	t2372 
	Defs:	t105 
Oper Node:	587		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	588		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	589		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	590		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	591		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	592		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	593		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	594		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	595		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	596		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	597		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	598		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	599	L1345:

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 
	Uses:	
	Defs:	
Oper Node:	600		li		'd0, 1

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 t2239 
	Uses:	
	Defs:	t2239 
Oper Node:	601		j		L1347


	Ins:	t100 t105 t106 t2214 t2239 
	Outs:	t100 t105 t106 t2214 t2239 
	Uses:	
	Defs:	
Oper Node:	602	L1356:

	Ins:	t105 t106 t2214 
	Outs:	t105 t106 t2214 
	Uses:	
	Defs:	
Oper Node:	603		la		'd0, L1348

	Ins:	t105 t106 t2214 
	Outs:	t105 t106 t2214 t2240 
	Uses:	
	Defs:	t2240 
Move Node:	604		move	'd0, 's0

	Ins:	t105 t106 t2214 t2240 
	Outs:	t105 t106 t2214 
	Uses:	t2240 
	Defs:	t108 
Oper Node:	605	
	Ins:	t105 t106 t2214 
	Outs:	t102 t105 t106 t2214 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	606		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	607	
	Ins:	t102 t105 t106 t2214 
	Outs:	t102 t105 t106 t2214 
	Uses:	
	Defs:	
Move Node:	608		move	'd0, 's0

	Ins:	t102 t105 t106 t2214 
	Outs:	t105 t106 t2214 
	Uses:	t102 
	Defs:	t2373 
Move Node:	609		move	'd0, 's0

	Ins:	t105 t106 t2214 
	Outs:	t105 t106 t2214 
	Uses:	t106 
	Defs:	t108 
Oper Node:	610		li		'd0, 0

	Ins:	t105 t106 t2214 
	Outs:	t105 t106 t2214 t2375 
	Uses:	
	Defs:	t2375 
Oper Node:	611		sub		'd0, 's0, 's1

	Ins:	t105 t106 t2214 t2375 
	Outs:	t105 t106 t2374 
	Uses:	t2214 t2375 
	Defs:	t2374 
Move Node:	612		move	'd0, 's0

	Ins:	t105 t106 t2374 
	Outs:	t105 t106 
	Uses:	t2374 
	Defs:	t109 
Oper Node:	613	
	Ins:	t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	614		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	615	
	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	616		move	'd0, 's0

	Ins:	t102 t103 t105 t106 
	Outs:	t103 t105 t106 t2376 
	Uses:	t102 
	Defs:	t2376 
Move Node:	617		move	'd0, 's0

	Ins:	t103 t105 t106 t2376 
	Outs:	t103 t105 t106 t2246 
	Uses:	t2376 
	Defs:	t2246 
Oper Node:	618		j		L1358


	Ins:	t103 t105 t106 t2246 
	Outs:	t103 t105 t106 t2246 
	Uses:	
	Defs:	
Oper Node:	619	L1349:

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 
	Uses:	
	Defs:	
Oper Node:	620		li		'd0, 1

	Ins:	t100 t105 t106 t2214 
	Outs:	t100 t105 t106 t2214 t2241 
	Uses:	
	Defs:	t2241 
Oper Node:	621		j		L1351


	Ins:	t100 t105 t106 t2214 t2241 
	Outs:	t100 t105 t106 t2214 t2241 
	Uses:	
	Defs:	
Oper Node:	622	L1353:

	Ins:	t105 t106 t2214 
	Outs:	t105 t106 t2214 
	Uses:	
	Defs:	
Move Node:	623		move	'd0, 's0

	Ins:	t105 t106 t2214 
	Outs:	t105 t106 t2214 
	Uses:	t106 
	Defs:	t108 
Move Node:	624		move	'd0, 's0

	Ins:	t105 t106 t2214 
	Outs:	t105 t106 
	Uses:	t2214 
	Defs:	t109 
Oper Node:	625	
	Ins:	t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	626		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 t2238 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	627	
	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	628		move	'd0, 's0

	Ins:	t102 t103 t105 t106 
	Outs:	t103 t105 t106 t2377 
	Uses:	t102 
	Defs:	t2377 
Move Node:	629		move	'd0, 's0

	Ins:	t103 t105 t106 t2377 
	Outs:	t103 t105 t106 t2244 
	Uses:	t2377 
	Defs:	t2244 
Oper Node:	630		j		L1355


	Ins:	t103 t105 t106 t2244 
	Outs:	t103 t105 t106 t2244 
	Uses:	
	Defs:	
Oper Node:	631	L1398:

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	632	L1313:

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	633		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t108 
	Defs:	
Oper Node:	634		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t106 
	Defs:	
Move Node:	635		move	'd0, 's0

	Ins:	t100 t105 t107 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 
	Uses:	t109 
	Defs:	t2213 
Move Node:	636		move	'd0, 's0

	Ins:	t100 t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 
	Uses:	t105 
	Defs:	t106 
Oper Node:	637		addi	'd0, 's0, -8

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 
	Outs:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 t2378 
	Uses:	t105 
	Defs:	t2378 
Move Node:	638		move	'd0, 's0

	Ins:	t100 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 t2378 
	Outs:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 
	Uses:	t2378 
	Defs:	t105 
Oper Node:	639		sw		's1, 0('s0)

	Ins:	t100 t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2213 
	Uses:	t105 t122 
	Defs:	
Oper Node:	640		sw		's1, -4('s0)

	Ins:	t100 t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2213 
	Uses:	t105 t123 
	Defs:	
Oper Node:	641		sw		's1, -8('s0)

	Ins:	t100 t105 t106 t107 t124 t125 t126 t127 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2213 
	Uses:	t105 t124 
	Defs:	
Oper Node:	642		sw		's1, -12('s0)

	Ins:	t100 t105 t106 t107 t125 t126 t127 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t126 t127 t128 t129 t2213 
	Uses:	t105 t125 
	Defs:	
Oper Node:	643		sw		's1, -16('s0)

	Ins:	t100 t105 t106 t107 t126 t127 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t127 t128 t129 t2213 
	Uses:	t105 t126 
	Defs:	
Oper Node:	644		sw		's1, -20('s0)

	Ins:	t100 t105 t106 t107 t127 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t128 t129 t2213 
	Uses:	t105 t127 
	Defs:	
Oper Node:	645		sw		's1, -24('s0)

	Ins:	t100 t105 t106 t107 t128 t129 t2213 
	Outs:	t100 t105 t106 t107 t129 t2213 
	Uses:	t105 t128 
	Defs:	
Oper Node:	646		sw		's1, -28('s0)

	Ins:	t100 t105 t106 t107 t129 t2213 
	Outs:	t100 t105 t106 t107 t2213 
	Uses:	t105 t129 
	Defs:	
Oper Node:	647		sw		's1, -32('s0)

	Ins:	t100 t105 t106 t107 t2213 
	Outs:	t100 t105 t106 t2213 
	Uses:	t105 t107 
	Defs:	
Oper Node:	648		addi	'd0, 's0, -36

	Ins:	t100 t105 t106 t2213 
	Outs:	t100 t106 t2213 t2379 
	Uses:	t105 
	Defs:	t2379 
Move Node:	649		move	'd0, 's0

	Ins:	t100 t106 t2213 t2379 
	Outs:	t100 t105 t106 t2213 
	Uses:	t2379 
	Defs:	t105 
Oper Node:	650		beq		's0, 's1, L1359
	j		L1360

	Ins:	t100 t105 t106 t2213 
	Outs:	t100 t105 t106 t2213 
	Uses:	t100 t2213 
	Defs:	t100 
Oper Node:	651	L1360:

	Ins:	t100 t105 t106 t2213 
	Outs:	t100 t105 t106 t2213 
	Uses:	
	Defs:	
Oper Node:	652		li		'd0, 0

	Ins:	t100 t105 t106 t2213 
	Outs:	t100 t105 t106 t2213 t2247 
	Uses:	
	Defs:	t2247 
Oper Node:	653	L1361:

	Ins:	t100 t105 t106 t2213 t2247 
	Outs:	t100 t105 t106 t2213 t2247 
	Uses:	
	Defs:	
Move Node:	654		move	'd0, 's0

	Ins:	t100 t105 t106 t2213 t2247 
	Outs:	t100 t105 t106 t2213 t2250 
	Uses:	t2247 
	Defs:	t2250 
Oper Node:	655		beq		's0, 's1, L1365
	j		 L1364

	Ins:	t100 t105 t106 t2213 t2250 
	Outs:	t105 t106 t2213 
	Uses:	t100 t2250 
	Defs:	t100 
Oper Node:	656	L1365:

	Ins:	t105 t106 t2213 
	Outs:	t105 t106 t2213 
	Uses:	
	Defs:	
Oper Node:	657		lw		'd0, 0('s0)

	Ins:	t105 t106 t2213 
	Outs:	t105 t106 t2213 
	Uses:	t106 
	Defs:	t108 
Oper Node:	658		lw		'd0, 0('s0)

	Ins:	t105 t106 t2213 
	Outs:	t105 t106 t2213 
	Uses:	t2213 
	Defs:	t109 
Oper Node:	659	
	Ins:	t105 t106 t2213 
	Outs:	t102 t105 t106 t2213 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	660		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	661	
	Ins:	t102 t105 t106 t2213 
	Outs:	t102 t105 t106 t2213 
	Uses:	
	Defs:	
Move Node:	662		move	'd0, 's0

	Ins:	t102 t105 t106 t2213 
	Outs:	t105 t106 t2213 
	Uses:	t102 
	Defs:	t2380 
Oper Node:	663		la		'd0, L1363

	Ins:	t105 t106 t2213 
	Outs:	t105 t106 t2213 t2249 
	Uses:	
	Defs:	t2249 
Move Node:	664		move	'd0, 's0

	Ins:	t105 t106 t2213 t2249 
	Outs:	t105 t106 t2213 
	Uses:	t2249 
	Defs:	t108 
Oper Node:	665	
	Ins:	t105 t106 t2213 
	Outs:	t102 t105 t106 t2213 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	666		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	667	
	Ins:	t102 t105 t106 t2213 
	Outs:	t102 t105 t106 t2213 
	Uses:	
	Defs:	
Move Node:	668		move	'd0, 's0

	Ins:	t102 t105 t106 t2213 
	Outs:	t105 t106 t2213 
	Uses:	t102 
	Defs:	t2381 
Oper Node:	669		lw		'd0, 0('s0)

	Ins:	t105 t106 t2213 
	Outs:	t105 t106 t2213 
	Uses:	t106 
	Defs:	t108 
Oper Node:	670		lw		'd0, 4('s0)

	Ins:	t105 t106 t2213 
	Outs:	t105 t106 
	Uses:	t2213 
	Defs:	t109 
Oper Node:	671	
	Ins:	t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	672		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	673	
	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	674		move	'd0, 's0

	Ins:	t102 t103 t105 t106 
	Outs:	t103 t105 t106 t2382 
	Uses:	t102 
	Defs:	t2382 
Move Node:	675		move	'd0, 's0

	Ins:	t103 t105 t106 t2382 
	Outs:	t103 t105 t106 t2251 
	Uses:	t2382 
	Defs:	t2251 
Oper Node:	676	L1366:

	Ins:	t103 t105 t106 t2251 
	Outs:	t103 t105 t106 t2251 
	Uses:	
	Defs:	
Move Node:	677		move	'd0, 's0

	Ins:	t103 t105 t106 t2251 
	Outs:	t102 t103 t105 t106 
	Uses:	t2251 
	Defs:	t102 
Oper Node:	678		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2383 
	Uses:	t105 
	Defs:	t2383 
Move Node:	679		move	'd0, 's0

	Ins:	t102 t103 t106 t2383 
	Outs:	t102 t103 t105 t106 
	Uses:	t2383 
	Defs:	t105 
Oper Node:	680		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	681		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	682		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	683		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	684		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	685		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	686		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	687		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	688		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	689		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	690		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	691		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	
Oper Node:	692	L1359:

	Ins:	t100 t105 t106 t2213 
	Outs:	t100 t105 t106 t2213 
	Uses:	
	Defs:	
Oper Node:	693		li		'd0, 1

	Ins:	t100 t105 t106 t2213 
	Outs:	t100 t105 t106 t2213 t2247 
	Uses:	
	Defs:	t2247 
Oper Node:	694		j		L1361


	Ins:	t100 t105 t106 t2213 t2247 
	Outs:	t100 t105 t106 t2213 t2247 
	Uses:	
	Defs:	
Oper Node:	695	L1364:

	Ins:	t105 t106 
	Outs:	t105 t106 
	Uses:	
	Defs:	
Oper Node:	696		la		'd0, L1362

	Ins:	t105 t106 
	Outs:	t105 t106 t2248 
	Uses:	
	Defs:	t2248 
Move Node:	697		move	'd0, 's0

	Ins:	t105 t106 t2248 
	Outs:	t105 t106 
	Uses:	t2248 
	Defs:	t108 
Oper Node:	698	
	Ins:	t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	699		jal		'j0


	Ins:	t108 
	Outs:	
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	700	
	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	701		move	'd0, 's0

	Ins:	t102 t103 t105 t106 
	Outs:	t103 t105 t106 t2384 
	Uses:	t102 
	Defs:	t2384 
Move Node:	702		move	'd0, 's0

	Ins:	t103 t105 t106 t2384 
	Outs:	t103 t105 t106 t2251 
	Uses:	t2384 
	Defs:	t2251 
Oper Node:	703		j		L1366


	Ins:	t103 t105 t106 t2251 
	Outs:	t103 t105 t106 t2251 
	Uses:	
	Defs:	
Oper Node:	704	L1403:

	Ins:	t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	705	tig_main:

	Ins:	t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	
	Defs:	
Oper Node:	706		sw		's1, 0('s0)

	Ins:	t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t108 
	Defs:	
Oper Node:	707		sw		's1, -4('s0)

	Ins:	t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t106 
	Defs:	
Move Node:	708		move	'd0, 's0

	Ins:	t105 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 
	Defs:	t106 
Oper Node:	709		addi	'd0, 's0, -8

	Ins:	t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2391 
	Uses:	t105 
	Defs:	t2391 
Move Node:	710		move	'd0, 's0

	Ins:	t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 t2391 
	Outs:	t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t2391 
	Defs:	t105 
Oper Node:	711		sw		's1, 0('s0)

	Ins:	t105 t106 t107 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t122 
	Defs:	
Oper Node:	712		sw		's1, -4('s0)

	Ins:	t105 t106 t107 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t124 t125 t126 t127 t128 t129 
	Uses:	t105 t123 
	Defs:	
Oper Node:	713		sw		's1, -8('s0)

	Ins:	t105 t106 t107 t124 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t125 t126 t127 t128 t129 
	Uses:	t105 t124 
	Defs:	
Oper Node:	714		sw		's1, -12('s0)

	Ins:	t105 t106 t107 t125 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t126 t127 t128 t129 
	Uses:	t105 t125 
	Defs:	
Oper Node:	715		sw		's1, -16('s0)

	Ins:	t105 t106 t107 t126 t127 t128 t129 
	Outs:	t105 t106 t107 t127 t128 t129 
	Uses:	t105 t126 
	Defs:	
Oper Node:	716		sw		's1, -20('s0)

	Ins:	t105 t106 t107 t127 t128 t129 
	Outs:	t105 t106 t107 t128 t129 
	Uses:	t105 t127 
	Defs:	
Oper Node:	717		sw		's1, -24('s0)

	Ins:	t105 t106 t107 t128 t129 
	Outs:	t105 t106 t107 t129 
	Uses:	t105 t128 
	Defs:	
Oper Node:	718		sw		's1, -28('s0)

	Ins:	t105 t106 t107 t129 
	Outs:	t105 t106 t107 
	Uses:	t105 t129 
	Defs:	
Oper Node:	719		sw		's1, -32('s0)

	Ins:	t105 t106 t107 
	Outs:	t105 t106 
	Uses:	t105 t107 
	Defs:	
Oper Node:	720		addi	'd0, 's0, -36

	Ins:	t105 t106 
	Outs:	t106 t2392 
	Uses:	t105 
	Defs:	t2392 
Move Node:	721		move	'd0, 's0

	Ins:	t106 t2392 
	Outs:	t105 t106 
	Uses:	t2392 
	Defs:	t105 
Oper Node:	722		addi	'd0, 's0, -8

	Ins:	t105 t106 
	Outs:	t105 t106 t2393 
	Uses:	t106 
	Defs:	t2393 
Move Node:	723		move	'd0, 's0

	Ins:	t105 t106 t2393 
	Outs:	t105 t106 t2386 
	Uses:	t2393 
	Defs:	t2386 
Oper Node:	724	
	Ins:	t105 t106 t2386 
	Outs:	t102 t105 t106 t2386 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	725		jal		'j0


	Ins:	
	Outs:	
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	726	
	Ins:	t102 t105 t106 t2386 
	Outs:	t102 t105 t106 t2386 
	Uses:	
	Defs:	
Move Node:	727		move	'd0, 's0

	Ins:	t102 t105 t106 t2386 
	Outs:	t105 t106 t2386 t2394 
	Uses:	t102 
	Defs:	t2394 
Move Node:	728		move	'd0, 's0

	Ins:	t105 t106 t2386 t2394 
	Outs:	t105 t106 t2385 t2386 
	Uses:	t2394 
	Defs:	t2385 
Oper Node:	729		sw		's1, 0('s0)

	Ins:	t105 t106 t2385 t2386 
	Outs:	t105 t106 
	Uses:	t2385 t2386 
	Defs:	
Move Node:	730		move	'd0, 's0

	Ins:	t105 t106 
	Outs:	t105 t106 
	Uses:	t106 
	Defs:	t108 
Oper Node:	731	
	Ins:	t105 t106 
	Outs:	t102 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	732		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	733	
	Ins:	t102 t105 t106 
	Outs:	t102 t105 t106 
	Uses:	
	Defs:	
Move Node:	734		move	'd0, 's0

	Ins:	t102 t105 t106 
	Outs:	t105 t106 t2395 
	Uses:	t102 
	Defs:	t2395 
Move Node:	735		move	'd0, 's0

	Ins:	t105 t106 t2395 
	Outs:	t105 t106 t2253 
	Uses:	t2395 
	Defs:	t2253 
Move Node:	736		move	'd0, 's0

	Ins:	t105 t106 t2253 
	Outs:	t105 t106 t2253 
	Uses:	t106 
	Defs:	t108 
Oper Node:	737	
	Ins:	t105 t106 t2253 
	Outs:	t102 t105 t106 t2253 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	738		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Outs:	t100 t105 t106 t107 t108 t122 t123 t124 t125 t126 t127 t128 t129 t2218 
	Uses:	t108 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	739	
	Ins:	t102 t105 t106 t2253 
	Outs:	t102 t105 t106 t2253 
	Uses:	
	Defs:	
Move Node:	740		move	'd0, 's0

	Ins:	t102 t105 t106 t2253 
	Outs:	t105 t106 t2253 t2396 
	Uses:	t102 
	Defs:	t2396 
Move Node:	741		move	'd0, 's0

	Ins:	t105 t106 t2253 t2396 
	Outs:	t105 t106 t2252 t2253 
	Uses:	t2396 
	Defs:	t2252 
Oper Node:	742		addi	'd0, 's0, -8

	Ins:	t105 t106 t2252 t2253 
	Outs:	t105 t106 t2252 t2253 t2397 
	Uses:	t106 
	Defs:	t2397 
Move Node:	743		move	'd0, 's0

	Ins:	t105 t106 t2252 t2253 t2397 
	Outs:	t105 t106 t2252 t2253 t2388 
	Uses:	t2397 
	Defs:	t2388 
Oper Node:	744	
	Ins:	t105 t106 t2252 t2253 t2388 
	Outs:	t102 t105 t106 t2252 t2253 t2388 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	745		jal		'j0


	Ins:	
	Outs:	
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	746	
	Ins:	t102 t105 t106 t2252 t2253 t2388 
	Outs:	t102 t105 t106 t2252 t2253 t2388 
	Uses:	
	Defs:	
Move Node:	747		move	'd0, 's0

	Ins:	t102 t105 t106 t2252 t2253 t2388 
	Outs:	t105 t106 t2252 t2253 t2388 t2398 
	Uses:	t102 
	Defs:	t2398 
Move Node:	748		move	'd0, 's0

	Ins:	t105 t106 t2252 t2253 t2388 t2398 
	Outs:	t105 t106 t2252 t2253 t2387 t2388 
	Uses:	t2398 
	Defs:	t2387 
Oper Node:	749		sw		's1, 0('s0)

	Ins:	t105 t106 t2252 t2253 t2387 t2388 
	Outs:	t105 t106 t2252 t2253 
	Uses:	t2387 t2388 
	Defs:	
Move Node:	750		move	'd0, 's0

	Ins:	t105 t106 t2252 t2253 
	Outs:	t105 t106 t2252 t2253 t2390 
	Uses:	t106 
	Defs:	t2390 
Move Node:	751		move	'd0, 's0

	Ins:	t105 t106 t2252 t2253 t2390 
	Outs:	t105 t106 t2252 t2253 t2390 
	Uses:	t106 
	Defs:	t108 
Move Node:	752		move	'd0, 's0

	Ins:	t105 t106 t2252 t2253 t2390 
	Outs:	t105 t106 t2253 t2390 
	Uses:	t2252 
	Defs:	t109 
Move Node:	753		move	'd0, 's0

	Ins:	t105 t106 t2253 t2390 
	Outs:	t105 t106 t2390 
	Uses:	t2253 
	Defs:	t110 
Oper Node:	754	
	Ins:	t105 t106 t2390 
	Outs:	t102 t105 t106 t2390 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	755		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t103 t105 t106 t107 t108 t109 t110 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 t110 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	756	
	Ins:	t102 t105 t106 t2390 
	Outs:	t102 t105 t106 t2390 
	Uses:	
	Defs:	
Move Node:	757		move	'd0, 's0

	Ins:	t102 t105 t106 t2390 
	Outs:	t105 t106 t2390 t2399 
	Uses:	t102 
	Defs:	t2399 
Move Node:	758		move	'd0, 's0

	Ins:	t105 t106 t2390 t2399 
	Outs:	t105 t106 t2389 t2390 
	Uses:	t2399 
	Defs:	t2389 
Move Node:	759		move	'd0, 's0

	Ins:	t105 t106 t2389 t2390 
	Outs:	t105 t106 t2389 
	Uses:	t2390 
	Defs:	t108 
Move Node:	760		move	'd0, 's0

	Ins:	t105 t106 t2389 
	Outs:	t105 t106 
	Uses:	t2389 
	Defs:	t109 
Oper Node:	761	
	Ins:	t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	762		jal		'j0


	Ins:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Outs:	t100 t105 t106 t107 t108 t109 t122 t123 t124 t125 t126 t127 t128 t129 
	Uses:	t108 t109 
	Defs:	t102 t103 t108 t109 t110 t111 t112 t113 t114 t115 t116 t117 t118 t119 t120 t121 
Oper Node:	763	
	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	
	Defs:	
Move Node:	764		move	'd0, 's0

	Ins:	t102 t103 t105 t106 
	Outs:	t103 t105 t106 t2400 
	Uses:	t102 
	Defs:	t2400 
Move Node:	765		move	'd0, 's0

	Ins:	t103 t105 t106 t2400 
	Outs:	t102 t103 t105 t106 
	Uses:	t2400 
	Defs:	t102 
Oper Node:	766		addi	'd0, 's0, 36

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t2401 
	Uses:	t105 
	Defs:	t2401 
Move Node:	767		move	'd0, 's0

	Ins:	t102 t103 t106 t2401 
	Outs:	t102 t103 t105 t106 
	Uses:	t2401 
	Defs:	t105 
Oper Node:	768		lw		'd0, 0('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t122 
Oper Node:	769		lw		'd0, -4('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t123 
Oper Node:	770		lw		'd0, -8('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t124 
Oper Node:	771		lw		'd0, -12('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t125 
Oper Node:	772		lw		'd0, -16('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t126 
Oper Node:	773		lw		'd0, -20('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t127 
Oper Node:	774		lw		'd0, -24('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t128 
Oper Node:	775		lw		'd0, -28('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t105 t106 
	Uses:	t105 
	Defs:	t129 
Oper Node:	776		lw		'd0, -32('s0)

	Ins:	t102 t103 t105 t106 
	Outs:	t102 t103 t106 t107 
	Uses:	t105 
	Defs:	t107 
Move Node:	777		move	'd0, 's0

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t106 t107 
	Uses:	t106 
	Defs:	t105 
Oper Node:	778		lw		'd0, -4('s0)

	Ins:	t102 t103 t106 t107 
	Outs:	t102 t103 t107 
	Uses:	t106 
	Defs:	t106 
Oper Node:	779		jr		's0


	Ins:	t102 t103 t107 
	Outs:	
	Uses:	t102 t103 t107 
	Defs:	

L210:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t584, $a1
	move	$fp, $sp
	addi	t645, $sp, -8
	move	$sp, t645
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t646, $sp, -36
	move	$sp, t646
	move	t577, t584
	lw		t648, 0($fp)
	lw		t647, 0(t648)
	lw		$a0, -8(t647)
	jal		tig_ord

	move	t649, $v0
	move	t639, t649
	move	t641, t639
	la		t578, L211
	move	$a0, t578
	jal		tig_ord

	move	t650, $v0
	move	t640, t650
	slt		t651, t641, t640
	beqz	t651, L212
	j		L213
L213:
	li		t579, 0
L214:
	move	t582, t579
	beq		t582, $zero, L220
	j		 L219
L220:
	li		t583, 0
L221:
	move	$v0, t583
	addi	t652, $sp, 36
	move	$sp, t652
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L212:
	li		t579, 1
	j		L214

L219:
	lw		t654, 0($fp)
	lw		t653, 0(t654)
	lw		$a0, -8(t653)
	jal		tig_ord

	move	t655, $v0
	move	t642, t655
	move	t644, t642
	la		t580, L215
	move	$a0, t580
	jal		tig_ord

	move	t656, $v0
	move	t643, t656
	slt		t657, t643, t644
	beqz	t657, L216
	j		L217
L217:
	li		t581, 0
L218:
	move	t583, t581
	j		L221

L216:
	li		t581, 1
	j		L218

L288:
L209:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t664, $sp, -8
	move	$sp, t664
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t665, $sp, -36
	move	$sp, t665
L228:
	move	t659, $fp
	lw		t667, 0($fp)
	lw		t666, 0(t667)
	lw		t658, -8(t666)
	la		t585, L222
	move	$a0, t659
	move	$a1, t658
	move	$a2, t585
	jal		tig_stringEqual

	move	t668, $v0
	move	t587, t668
	beq		t587, $zero, L225
	j		 L224
L225:
	move	t661, $fp
	lw		t670, 0($fp)
	lw		t669, 0(t670)
	lw		t660, -8(t669)
	la		t586, L223
	move	$a0, t661
	move	$a1, t660
	move	$a2, t586
	jal		tig_stringEqual

	move	t671, $v0
	move	t588, t671
L226:
	move	t589, t588
	beq		t589, $zero, L227
	j		 L229
L227:
	li		$v0, 0
	addi	t672, $sp, 36
	move	$sp, t672
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L224:
	li		t588, 1
	j		L226

L229:
	lw		t675, 0($fp)
	lw		t674, 0(t675)
	addi	t673, t674, -8
	move	t663, t673
	jal		tig_getchar

	move	t676, $v0
	move	t662, t676
	sw		t662, 0(t663)
	j		L228

L293:
L208:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t592, $a1
	move	$fp, $sp
	addi	t685, $sp, -8
	move	$sp, t685
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t686, $sp, -36
	move	$sp, t686
	move	t575, t592
	li		t576, 0
	move	$a0, $fp
	jal		L209

	move	t687, $v0
	move	t688, t575
	move	t678, t688
	move	$a0, $fp
	lw		t689, 0($fp)
	lw		$a1, -8(t689)
	jal		L210

	move	t690, $v0
	move	t677, t690
	sw		t677, 0(t678)
L232:
	move	$a0, $fp
	lw		t691, 0($fp)
	lw		$a1, -8(t691)
	jal		L210

	move	t692, $v0
	move	t591, t692
	beq		t591, $zero, L230
	j		 L233
L230:
	move	$v0, t576
	addi	t693, $sp, 36
	move	$sp, t693
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L233:
	li		t695, 10
	mult	t576, t695
	mflo	t694
	move	t680, t694
	lw		t696, 0($fp)
	lw		$a0, -8(t696)
	jal		tig_ord

	move	t697, $v0
	move	t679, t697
	add		t698, t680, t679
	move	t682, t698
	la		t590, L231
	move	$a0, t590
	jal		tig_ord

	move	t699, $v0
	move	t681, t699
	sub		t700, t682, t681
	move	t576, t700
	lw		t702, 0($fp)
	addi	t701, t702, -8
	move	t684, t701
	jal		tig_getchar

	move	t703, $v0
	move	t683, t703
	sw		t683, 0(t684)
	j		L232

L297:
L237:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t706, $sp, -8
	move	$sp, t706
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t707, $sp, -36
	move	$sp, t707
	li		$a0, 4
	jal		tig_allocRecord

	move	t708, $v0
	move	t597, t708
	li		t709, 0
	sw		t709, 0($v0)
	move	t598, t597
	lw		$a0, 0($fp)
	move	$a1, t598
	jal		L208

	move	t710, $v0
	move	t599, t710
	lw		t601, 0(t598)
	beq		t601, $zero, L239
	j		 L238
L239:
	li		t602, 0
L240:
	move	$v0, t602
	addi	t711, $sp, 36
	move	$sp, t711
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L238:
	li		$a0, 8
	jal		tig_allocRecord

	move	t712, $v0
	move	t600, t712
	sw		t599, 0($v0)
	addi	t713, $v0, 4
	move	t705, t713
	lw		$a0, 0($fp)
	jal		L237

	move	t714, $v0
	move	t704, t714
	sw		t704, 0(t705)
	move	t602, t600
	j		L240

L304:
L236:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t614, $a1
	move	t615, $a2
	move	$fp, $sp
	addi	t719, $sp, -8
	move	$sp, t719
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t720, $sp, -36
	move	$sp, t720
	move	t595, t614
	move	t596, t615
	beq		t595, $zero, L241
	j		L242
L242:
	li		t603, 0
L243:
	move	t612, t603
	beq		t612, $zero, L257
	j		 L256
L257:
	beq		t596, $zero, L244
	j		L245
L245:
	li		t604, 0
L246:
	move	t610, t604
	beq		t610, $zero, L254
	j		 L253
L254:
	lw		t722, 0(t595)
	lw		t723, 0(t596)
	slt		t721, t722, t723
	beqz	t721, L248
	j		L247
L248:
	li		t605, 0
L249:
	move	t608, t605
	beq		t608, $zero, L251
	j		 L250
L251:
	li		$a0, 8
	jal		tig_allocRecord

	move	t724, $v0
	move	t607, t724
	lw		t725, 0(t596)
	sw		t725, 0($v0)
	addi	t726, $v0, 4
	move	t718, t726
	lw		$a0, 0($fp)
	move	$a1, t595
	lw		$a2, 4(t596)
	jal		L236

	move	t727, $v0
	move	t717, t727
	sw		t717, 0(t718)
	move	t609, t607
L252:
	move	t611, t609
L255:
	move	t613, t611
L258:
	move	$v0, t613
	addi	t728, $sp, 36
	move	$sp, t728
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L241:
	li		t603, 1
	j		L243

L256:
	move	t613, t596
	j		L258

L244:
	li		t604, 1
	j		L246

L253:
	move	t611, t595
	j		L255

L247:
	li		t605, 1
	j		L249

L250:
	li		$a0, 8
	jal		tig_allocRecord

	move	t729, $v0
	move	t606, t729
	lw		t730, 0(t595)
	sw		t730, 0($v0)
	addi	t731, $v0, 4
	move	t716, t731
	lw		$a0, 0($fp)
	lw		$a1, 4(t595)
	move	$a2, t596
	jal		L236

	move	t732, $v0
	move	t715, t732
	sw		t715, 0(t716)
	move	t609, t606
	j		L252

L309:
L259:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t621, $a1
	move	$fp, $sp
	addi	t736, $sp, -8
	move	$sp, t736
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t737, $sp, -36
	move	$sp, t737
	move	t616, t621
	slt		t738, $zero, t616	beqz	t738, L261
	j		L260
L261:
	li		t617, 0
L262:
	move	t619, t617
	beq		t619, $zero, L265
	j		 L264
L265:
	move	$v0, t620
	addi	t739, $sp, 36
	move	$sp, t739
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L260:
	li		t617, 1
	j		L262

L264:
	lw		$a0, 0($fp)
	li		t741, 10
	div		t616, t741
	mflo	t740
	move	$a1, t740
	jal		L259

	move	t742, $v0
	li		t746, 10
	div		t616, t746
	mflo	t745
	li		t747, 10
	mult	t745, t747
	mflo	t744
	sub		t743, t616, t744
	move	t735, t743
	la		t618, L263
	move	$a0, t618
	jal		tig_ord

	move	t748, $v0
	move	t734, t748
	add		t749, t735, t734
	move	$a0, t749
	jal		tig_chr

	move	t750, $v0
	move	t733, t750
	move	$a0, t733
	jal		tig_print

	move	t751, $v0
	move	t620, t751
	j		L265

L314:
L235:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t630, $a1
	move	$fp, $sp
	addi	t752, $sp, -8
	move	$sp, t752
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t753, $sp, -36
	move	$sp, t753
	move	t594, t630
	slt		t754, t594, $zero
	beqz	t754, L267
	j		L266
L267:
	li		t622, 0
L268:
	move	t628, t622
	beq		t628, $zero, L278
	j		 L277
L278:
	slt		t755, $zero, t594	beqz	t755, L271
	j		L270
L271:
	li		t624, 0
L272:
	move	t626, t624
	beq		t626, $zero, L275
	j		 L274
L275:
	la		t625, L273
	move	$a0, t625
	jal		tig_print

	move	t756, $v0
	move	t627, t756
L276:
	move	t629, t627
L279:
	move	$v0, t629
	addi	t757, $sp, 36
	move	$sp, t757
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L266:
	li		t622, 1
	j		L268

L277:
	la		t623, L269
	move	$a0, t623
	jal		tig_print

	move	t758, $v0
	move	$a0, $fp
	li		t760, 0
	sub		t759, t760, t594
	move	$a1, t759
	jal		L259

	move	t761, $v0
	move	t629, t761
	j		L279

L270:
	li		t624, 1
	j		L272

L274:
	move	$a0, $fp
	move	$a1, t594
	jal		L259

	move	t762, $v0
	move	t627, t762
	j		L276

L319:
L234:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t636, $a1
	move	$fp, $sp
	addi	t763, $sp, -8
	move	$sp, t763
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t764, $sp, -36
	move	$sp, t764
	move	t593, t636
	beq		t593, $zero, L280
	j		L281
L281:
	li		t631, 0
L282:
	move	t634, t631
	beq		t634, $zero, L286
	j		 L285
L286:
	lw		$a0, 0($fp)
	lw		$a1, 0(t593)
	jal		L235

	move	t765, $v0
	la		t633, L284
	move	$a0, t633
	jal		tig_print

	move	t766, $v0
	lw		$a0, 0($fp)
	lw		$a1, 4(t593)
	jal		L234

	move	t767, $v0
	move	t635, t767
L287:
	move	$v0, t635
	addi	t768, $sp, 36
	move	$sp, t768
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L280:
	li		t631, 1
	j		L282

L285:
	la		t632, L283
	move	$a0, t632
	jal		tig_print

	move	t769, $v0
	move	t635, t769
	j		L287

L324:
tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t776, $sp, -8
	move	$sp, t776
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t777, $sp, -36
	move	$sp, t777
	addi	t778, $fp, -8
	move	t771, t778
	jal		tig_getchar

	move	t779, $v0
	move	t770, t779
	sw		t770, 0(t771)
	move	$a0, $fp
	jal		L237

	move	t780, $v0
	move	t637, t780
	addi	t781, $fp, -8
	move	t773, t781
	jal		tig_getchar

	move	t782, $v0
	move	t772, t782
	sw		t772, 0(t773)
	move	$a0, $fp
	jal		L237

	move	t783, $v0
	move	t638, t783
	move	t775, $fp
	move	$a0, $fp
	move	$a1, t637
	move	$a2, t638
	jal		L236

	move	t784, $v0
	move	t774, t784
	move	$a0, t775
	move	$a1, t774
	jal		L234

	move	t785, $v0
	move	$v0, t785
	addi	t786, $sp, 36
	move	$sp, t786
	lw		$s0, 0($sp)
	lw		$s1, -4($sp)
	lw		$s2, -8($sp)
	lw		$s3, -12($sp)
	lw		$s4, -16($sp)
	lw		$s5, -20($sp)
	lw		$s6, -24($sp)
	lw		$s7, -28($sp)
	lw		$ra, -32($sp)
	move	$sp, $fp
	lw		$fp, -4($fp)
	jr		$ra

L329:

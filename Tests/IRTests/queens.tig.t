L497:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1034, $sp, -16
	move	$sp, t1034
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1035, $sp, -36
	move	$sp, t1035
	lw		t1038, 0($fp)
	lw		t1037, -8(t1038)
	addi	t1036, t1037, -1
	move	t997, t1036
	li		t998, 0
L514:
	slt		t1039, t998, t997
	beqz	t1039, L498
	j		L515
L498:
	la		t999, L516
	move	$a0, t999
	jal		tig_print

	move	t1040, $v0
	move	$v0, t1040
	addi	t1041, $sp, 36
	move	$sp, t1041
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

L515:
	addi	t1042, t998, 1
	move	t998, t1042
	lw		t1045, 0($fp)
	lw		t1044, -8(t1045)
	addi	t1043, t1044, -1
	move	t994, t1043
	li		t995, 0
L511:
	slt		t1046, t995, t994
	beqz	t1046, L499
	j		L512
L499:
	la		t996, L513
	move	$a0, t996
	jal		tig_print

	move	t1047, $v0
	j		L514

L512:
	addi	t1048, t995, 1
	move	t995, t1048
	lw		t987, -8($fp)
	lw		t1049, 0($fp)
	lw		t988, -16(t1049)
	slt		t1050, t987, $zero
	beqz	t1050, L500
	j		L501
L501:
	li		$a0, 1
	jal		tig_exit

	move	t1051, $v0
L502:
	li		t1055, 4
	mult	t987, t1055
	mflo	t1054
	add		t1053, t1054, t988
	lw		t1052, 0(t1053)
	lw		t1056, -12($fp)
	beq		t1052, t1056, L503
	j		L504
L504:
	li		t989, 0
L505:
	move	t992, t989
	beq		t992, $zero, L509
	j		 L508
L509:
	la		t991, L507
	move	t993, t991
L510:
	move	$a0, t993
	jal		tig_print

	move	t1057, $v0
	j		L511

L500:
	lw		t1059, -4(t988)
	slt		t1058, t987, t1059
	beqz	t1058, L574
	j		L502
L574:
	j		L501

L503:
	li		t989, 1
	j		L505

L508:
	la		t990, L506
	move	t993, t990
	j		L510

L573:
L496:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t986, $a1
	move	$fp, $sp
	addi	t1060, $sp, -12
	move	$sp, t1060
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1061, $sp, -36
	move	$sp, t1061
	lw		t1063, 0($fp)
	lw		t1062, -8(t1063)
	beq		t986, t1062, L517
	j		L518
L518:
	li		t1000, 0
L519:
	move	t1032, t1000
	beq		t1032, $zero, L571
	j		 L570
L571:
	lw		t1066, 0($fp)
	lw		t1065, -8(t1066)
	addi	t1064, t1065, -1
	move	t1030, t1064
	li		t1031, 0
L568:
	slt		t1067, t1031, t1030
	beqz	t1067, L520
	j		L569
L520:
	li		t1033, 0
L572:
	move	$v0, t1033
	addi	t1068, $sp, 36
	move	$sp, t1068
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

L517:
	li		t1000, 1
	j		L519

L570:
	lw		$a0, 0($fp)
	jal		L497

	move	t1069, $v0
	move	t1033, t1069
	j		L572

L569:
	addi	t1070, t1031, 1
	move	t1031, t1070
	lw		t1001, -8($fp)
	lw		t1071, 0($fp)
	lw		t1002, -12(t1071)
	slt		t1072, t1001, $zero
	beqz	t1072, L521
	j		L522
L522:
	li		$a0, 1
	jal		tig_exit

	move	t1073, $v0
L523:
	li		t1077, 4
	mult	t1001, t1077
	mflo	t1076
	add		t1075, t1076, t1002
	lw		t1074, 0(t1075)
	beq		t1074, $zero, L524
	j		L525
L525:
	li		t1003, 0
L526:
	move	t1007, t1003
	beq		t1007, $zero, L534
	j		 L533
L534:
	li		t1008, 0
L535:
	move	t1012, t1008
	beq		t1012, $zero, L543
	j		 L542
L543:
	li		t1013, 0
L544:
	move	t1028, t1013
	beq		t1028, $zero, L567
	j		 L566
L567:
	j		L568

L521:
	lw		t1079, -4(t1002)
	slt		t1078, t1001, t1079
	beqz	t1078, L580
	j		L523
L580:
	j		L522

L524:
	li		t1003, 1
	j		L526

L533:
	lw		t1081, -8($fp)
	add		t1080, t1081, t986
	move	t1004, t1080
	lw		t1082, 0($fp)
	lw		t1005, -20(t1082)
	slt		t1083, t1004, $zero
	beqz	t1083, L527
	j		L528
L528:
	li		$a0, 1
	jal		tig_exit

	move	t1084, $v0
L529:
	li		t1088, 4
	mult	t1004, t1088
	mflo	t1087
	add		t1086, t1087, t1005
	lw		t1085, 0(t1086)
	beq		t1085, $zero, L530
	j		L531
L531:
	li		t1006, 0
L532:
	move	t1008, t1006
	j		L535

L527:
	lw		t1090, -4(t1005)
	slt		t1089, t1004, t1090
	beqz	t1089, L581
	j		L529
L581:
	j		L528

L530:
	li		t1006, 1
	j		L532

L542:
	lw		t1093, -8($fp)
	addi	t1092, t1093, 7
	sub		t1091, t1092, t986
	move	t1009, t1091
	lw		t1094, 0($fp)
	lw		t1010, -24(t1094)
	slt		t1095, t1009, $zero
	beqz	t1095, L536
	j		L537
L537:
	li		$a0, 1
	jal		tig_exit

	move	t1096, $v0
L538:
	li		t1100, 4
	mult	t1009, t1100
	mflo	t1099
	add		t1098, t1099, t1010
	lw		t1097, 0(t1098)
	beq		t1097, $zero, L539
	j		L540
L540:
	li		t1011, 0
L541:
	move	t1013, t1011
	j		L544

L536:
	lw		t1102, -4(t1010)
	slt		t1101, t1009, t1102
	beqz	t1101, L582
	j		L538
L582:
	j		L537

L539:
	li		t1011, 1
	j		L541

L566:
	lw		t1014, -8($fp)
	lw		t1103, 0($fp)
	lw		t1015, -12(t1103)
	slt		t1104, t1014, $zero
	beqz	t1104, L545
	j		L546
L546:
	li		$a0, 1
	jal		tig_exit

	move	t1105, $v0
L547:
	li		t1108, 4
	mult	t1014, t1108
	mflo	t1107
	add		t1106, t1107, t1015
	li		t1109, 1
	sw		t1109, 0(t1106)
	lw		t1111, -8($fp)
	add		t1110, t1111, t986
	move	t1016, t1110
	lw		t1112, 0($fp)
	lw		t1017, -20(t1112)
	slt		t1113, t1016, $zero
	beqz	t1113, L548
	j		L549
L549:
	li		$a0, 1
	jal		tig_exit

	move	t1114, $v0
L550:
	li		t1117, 4
	mult	t1016, t1117
	mflo	t1116
	add		t1115, t1116, t1017
	li		t1118, 1
	sw		t1118, 0(t1115)
	lw		t1121, -8($fp)
	addi	t1120, t1121, 7
	sub		t1119, t1120, t986
	move	t1018, t1119
	lw		t1122, 0($fp)
	lw		t1019, -24(t1122)
	slt		t1123, t1018, $zero
	beqz	t1123, L551
	j		L552
L552:
	li		$a0, 1
	jal		tig_exit

	move	t1124, $v0
L553:
	li		t1127, 4
	mult	t1018, t1127
	mflo	t1126
	add		t1125, t1126, t1019
	li		t1128, 1
	sw		t1128, 0(t1125)
	move	t1020, t986
	lw		t1129, 0($fp)
	lw		t1021, -16(t1129)
	slt		t1130, t1020, $zero
	beqz	t1130, L554
	j		L555
L555:
	li		$a0, 1
	jal		tig_exit

	move	t1131, $v0
L556:
	addi	t1133, $fp, -8
	lw		t1132, 0(t1133)
	li		t1136, 4
	mult	t1020, t1136
	mflo	t1135
	add		t1134, t1135, t1021
	sw		t1132, 0(t1134)
	lw		$a0, 0($fp)
	addi	t1137, t986, 1
	move	$a1, t1137
	jal		L496

	move	t1138, $v0
	lw		t1022, -8($fp)
	lw		t1139, 0($fp)
	lw		t1023, -12(t1139)
	slt		t1140, t1022, $zero
	beqz	t1140, L557
	j		L558
L558:
	li		$a0, 1
	jal		tig_exit

	move	t1141, $v0
L559:
	li		t1144, 4
	mult	t1022, t1144
	mflo	t1143
	add		t1142, t1143, t1023
	li		t1145, 0
	sw		t1145, 0(t1142)
	lw		t1147, -8($fp)
	add		t1146, t1147, t986
	move	t1024, t1146
	lw		t1148, 0($fp)
	lw		t1025, -20(t1148)
	slt		t1149, t1024, $zero
	beqz	t1149, L560
	j		L561
L561:
	li		$a0, 1
	jal		tig_exit

	move	t1150, $v0
L562:
	li		t1153, 4
	mult	t1024, t1153
	mflo	t1152
	add		t1151, t1152, t1025
	li		t1154, 0
	sw		t1154, 0(t1151)
	lw		t1157, -8($fp)
	addi	t1156, t1157, 7
	sub		t1155, t1156, t986
	move	t1026, t1155
	lw		t1158, 0($fp)
	lw		t1027, -24(t1158)
	slt		t1159, t1026, $zero
	beqz	t1159, L563
	j		L564
L564:
	li		$a0, 1
	jal		tig_exit

	move	t1160, $v0
L565:
	li		t1163, 4
	mult	t1026, t1163
	mflo	t1162
	add		t1161, t1162, t1027
	li		t1164, 0
	sw		t1164, 0(t1161)
	li		t1029, 0
	j		L567

L545:
	lw		t1166, -4(t1015)
	slt		t1165, t1014, t1166
	beqz	t1165, L583
	j		L547
L583:
	j		L546

L548:
	lw		t1168, -4(t1017)
	slt		t1167, t1016, t1168
	beqz	t1167, L584
	j		L550
L584:
	j		L549

L551:
	lw		t1170, -4(t1019)
	slt		t1169, t1018, t1170
	beqz	t1169, L585
	j		L553
L585:
	j		L552

L554:
	lw		t1172, -4(t1021)
	slt		t1171, t1020, t1172
	beqz	t1171, L586
	j		L556
L586:
	j		L555

L557:
	lw		t1174, -4(t1023)
	slt		t1173, t1022, t1174
	beqz	t1173, L587
	j		L559
L587:
	j		L558

L560:
	lw		t1176, -4(t1025)
	slt		t1175, t1024, t1176
	beqz	t1175, L588
	j		L562
L588:
	j		L561

L563:
	lw		t1178, -4(t1027)
	slt		t1177, t1026, t1178
	beqz	t1177, L589
	j		L565
L589:
	j		L564

L579:
tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1183, $sp, -8
	move	$sp, t1183
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1184, $sp, -36
	move	$sp, t1184
	addi	t1185, $fp, -24
	move	t1179, t1185
	lw		t1188, -8($fp)
	lw		t1189, -8($fp)
	add		t1187, t1188, t1189
	addi	t1186, t1187, -1
	move	$a0, t1186
	li		$a1, 0
	jal		tig_initArray

	move	t1190, $v0
	move	t985, t1190
	addi	t1191, t985, 4
	sw		t1191, 0(t1179)
	addi	t1192, $fp, -20
	move	t1180, t1192
	lw		t1195, -8($fp)
	lw		t1196, -8($fp)
	add		t1194, t1195, t1196
	addi	t1193, t1194, -1
	move	$a0, t1193
	li		$a1, 0
	jal		tig_initArray

	move	t1197, $v0
	move	t984, t1197
	addi	t1198, t984, 4
	sw		t1198, 0(t1180)
	addi	t1199, $fp, -16
	move	t1181, t1199
	lw		$a0, -8($fp)
	li		$a1, 0
	jal		tig_initArray

	move	t1200, $v0
	move	t983, t1200
	addi	t1201, t983, 4
	sw		t1201, 0(t1181)
	addi	t1202, $fp, -12
	move	t1182, t1202
	lw		$a0, -8($fp)
	li		$a1, 0
	jal		tig_initArray

	move	t1203, $v0
	move	t982, t1203
	addi	t1204, t982, 4
	sw		t1204, 0(t1182)
	li		t1205, 8
	sw		t1205, -8($fp)
	move	$a0, $fp
	li		$a1, 0
	jal		L496

	move	t1206, $v0
	move	$v0, t1206
	addi	t1207, $sp, 36
	move	$sp, t1207
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

L602:

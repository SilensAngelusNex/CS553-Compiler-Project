L738:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t1433, $a1
	move	$fp, $sp
	addi	t1494, $sp, -8
	move	$sp, t1494
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1495, $sp, -36
	move	$sp, t1495
	move	t1426, t1433
	lw		t1497, 0($fp)
	lw		t1496, 0(t1497)
	lw		$a0, -8(t1496)
	jal		tig_ord

	move	t1498, $v0
	move	t1488, t1498
	move	t1490, t1488
	la		t1427, L739
	move	$a0, t1427
	jal		tig_ord

	move	t1499, $v0
	move	t1489, t1499
	slt		t1500, t1490, t1489
	beqz	t1500, L740
	j		L741
L741:
	li		t1428, 0
L742:
	move	t1431, t1428
	beq		t1431, $zero, L748
	j		 L747
L748:
	li		t1432, 0
L749:
	move	$v0, t1432
	addi	t1501, $sp, 36
	move	$sp, t1501
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

L740:
	li		t1428, 1
	j		L742

L747:
	lw		t1503, 0($fp)
	lw		t1502, 0(t1503)
	lw		$a0, -8(t1502)
	jal		tig_ord

	move	t1504, $v0
	move	t1491, t1504
	move	t1493, t1491
	la		t1429, L743
	move	$a0, t1429
	jal		tig_ord

	move	t1505, $v0
	move	t1492, t1505
	slt		t1506, t1492, t1493
	beqz	t1506, L744
	j		L745
L745:
	li		t1430, 0
L746:
	move	t1432, t1430
	j		L749

L744:
	li		t1430, 1
	j		L746

L816:
L737:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1513, $sp, -8
	move	$sp, t1513
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1514, $sp, -36
	move	$sp, t1514
L756:
	move	t1508, $fp
	lw		t1516, 0($fp)
	lw		t1515, 0(t1516)
	lw		t1507, -8(t1515)
	la		t1434, L750
	move	$a0, t1508
	move	$a1, t1507
	move	$a2, t1434
	jal		tig_stringEqual

	move	t1517, $v0
	move	t1436, t1517
	beq		t1436, $zero, L753
	j		 L752
L753:
	move	t1510, $fp
	lw		t1519, 0($fp)
	lw		t1518, 0(t1519)
	lw		t1509, -8(t1518)
	la		t1435, L751
	move	$a0, t1510
	move	$a1, t1509
	move	$a2, t1435
	jal		tig_stringEqual

	move	t1520, $v0
	move	t1437, t1520
L754:
	move	t1438, t1437
	beq		t1438, $zero, L755
	j		 L757
L755:
	li		$v0, 0
	addi	t1521, $sp, 36
	move	$sp, t1521
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

L752:
	li		t1437, 1
	j		L754

L757:
	lw		t1524, 0($fp)
	lw		t1523, 0(t1524)
	addi	t1522, t1523, -8
	move	t1512, t1522
	jal		tig_getchar

	move	t1525, $v0
	move	t1511, t1525
	sw		t1511, 0(t1512)
	j		L756

L821:
L736:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t1441, $a1
	move	$fp, $sp
	addi	t1534, $sp, -8
	move	$sp, t1534
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1535, $sp, -36
	move	$sp, t1535
	move	t1424, t1441
	li		t1425, 0
	move	$a0, $fp
	jal		L737

	move	t1536, $v0
	move	t1537, t1424
	move	t1527, t1537
	move	$a0, $fp
	lw		t1538, 0($fp)
	lw		$a1, -8(t1538)
	jal		L738

	move	t1539, $v0
	move	t1526, t1539
	sw		t1526, 0(t1527)
L760:
	move	$a0, $fp
	lw		t1540, 0($fp)
	lw		$a1, -8(t1540)
	jal		L738

	move	t1541, $v0
	move	t1440, t1541
	beq		t1440, $zero, L758
	j		 L761
L758:
	move	$v0, t1425
	addi	t1542, $sp, 36
	move	$sp, t1542
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

L761:
	li		t1544, 10
	mult	t1425, t1544
	mflo	t1543
	move	t1529, t1543
	lw		t1545, 0($fp)
	lw		$a0, -8(t1545)
	jal		tig_ord

	move	t1546, $v0
	move	t1528, t1546
	add		t1547, t1529, t1528
	move	t1531, t1547
	la		t1439, L759
	move	$a0, t1439
	jal		tig_ord

	move	t1548, $v0
	move	t1530, t1548
	sub		t1549, t1531, t1530
	move	t1425, t1549
	lw		t1551, 0($fp)
	addi	t1550, t1551, -8
	move	t1533, t1550
	jal		tig_getchar

	move	t1552, $v0
	move	t1532, t1552
	sw		t1532, 0(t1533)
	j		L760

L825:
L765:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1555, $sp, -8
	move	$sp, t1555
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1556, $sp, -36
	move	$sp, t1556
	lw		$a0, 0($fp)
	move	$a1, t1447
	jal		L736

	move	t1557, $v0
	move	t1448, t1557
	li		$a0, 4
	jal		tig_allocRecord

	move	t1558, $v0
	move	t1446, t1558
	li		t1559, 0
	sw		t1559, 0($v0)
	move	t1447, t1446
	lw		t1450, 0(t1447)
	beq		t1450, $zero, L767
	j		 L766
L767:
	li		t1451, 0
L768:
	move	$v0, t1451
	addi	t1560, $sp, 36
	move	$sp, t1560
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

L766:
	li		$a0, 8
	jal		tig_allocRecord

	move	t1561, $v0
	move	t1449, t1561
	sw		t1448, 0($v0)
	addi	t1562, $v0, 4
	move	t1554, t1562
	lw		$a0, 0($fp)
	jal		L765

	move	t1563, $v0
	move	t1553, t1563
	sw		t1553, 0(t1554)
	move	t1451, t1449
	j		L768

L832:
L764:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t1463, $a1
	move	t1464, $a2
	move	$fp, $sp
	addi	t1568, $sp, -8
	move	$sp, t1568
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1569, $sp, -36
	move	$sp, t1569
	move	t1444, t1463
	move	t1445, t1464
	beq		t1444, $zero, L769
	j		L770
L770:
	li		t1452, 0
L771:
	move	t1461, t1452
	beq		t1461, $zero, L785
	j		 L784
L785:
	beq		t1445, $zero, L772
	j		L773
L773:
	li		t1453, 0
L774:
	move	t1459, t1453
	beq		t1459, $zero, L782
	j		 L781
L782:
	lw		t1571, 0(t1444)
	lw		t1572, 0(t1445)
	slt		t1570, t1571, t1572
	beqz	t1570, L776
	j		L775
L776:
	li		t1454, 0
L777:
	move	t1457, t1454
	beq		t1457, $zero, L779
	j		 L778
L779:
	li		$a0, 8
	jal		tig_allocRecord

	move	t1573, $v0
	move	t1456, t1573
	lw		t1574, 0(t1445)
	sw		t1574, 0($v0)
	addi	t1575, $v0, 4
	move	t1567, t1575
	lw		$a0, 0($fp)
	move	$a1, t1444
	lw		$a2, 4(t1445)
	jal		L764

	move	t1576, $v0
	move	t1566, t1576
	sw		t1566, 0(t1567)
	move	t1458, t1456
L780:
	move	t1460, t1458
L783:
	move	t1462, t1460
L786:
	move	$v0, t1462
	addi	t1577, $sp, 36
	move	$sp, t1577
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

L769:
	li		t1452, 1
	j		L771

L784:
	move	t1462, t1445
	j		L786

L772:
	li		t1453, 1
	j		L774

L781:
	move	t1460, t1444
	j		L783

L775:
	li		t1454, 1
	j		L777

L778:
	li		$a0, 8
	jal		tig_allocRecord

	move	t1578, $v0
	move	t1455, t1578
	lw		t1579, 0(t1444)
	sw		t1579, 0($v0)
	addi	t1580, $v0, 4
	move	t1565, t1580
	lw		$a0, 0($fp)
	lw		$a1, 4(t1444)
	move	$a2, t1445
	jal		L764

	move	t1581, $v0
	move	t1564, t1581
	sw		t1564, 0(t1565)
	move	t1458, t1455
	j		L780

L837:
L787:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t1470, $a1
	move	$fp, $sp
	addi	t1585, $sp, -8
	move	$sp, t1585
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1586, $sp, -36
	move	$sp, t1586
	move	t1465, t1470
	slt		t1587, $zero, t1465	beqz	t1587, L789
	j		L788
L789:
	li		t1466, 0
L790:
	move	t1468, t1466
	beq		t1468, $zero, L793
	j		 L792
L793:
	move	$v0, t1469
	addi	t1588, $sp, 36
	move	$sp, t1588
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

L788:
	li		t1466, 1
	j		L790

L792:
	lw		$a0, 0($fp)
	li		t1590, 10
	div		t1465, t1590
	mflo	t1589
	move	$a1, t1589
	jal		L787

	move	t1591, $v0
	li		t1595, 10
	div		t1465, t1595
	mflo	t1594
	li		t1596, 10
	mult	t1594, t1596
	mflo	t1593
	sub		t1592, t1465, t1593
	move	t1584, t1592
	la		t1467, L791
	move	$a0, t1467
	jal		tig_ord

	move	t1597, $v0
	move	t1583, t1597
	add		t1598, t1584, t1583
	move	$a0, t1598
	jal		tig_chr

	move	t1599, $v0
	move	t1582, t1599
	move	$a0, t1582
	jal		tig_print

	move	t1600, $v0
	move	t1469, t1600
	j		L793

L842:
L763:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t1479, $a1
	move	$fp, $sp
	addi	t1601, $sp, -8
	move	$sp, t1601
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1602, $sp, -36
	move	$sp, t1602
	move	t1443, t1479
	slt		t1603, t1443, $zero
	beqz	t1603, L795
	j		L794
L795:
	li		t1471, 0
L796:
	move	t1477, t1471
	beq		t1477, $zero, L806
	j		 L805
L806:
	slt		t1604, $zero, t1443	beqz	t1604, L799
	j		L798
L799:
	li		t1473, 0
L800:
	move	t1475, t1473
	beq		t1475, $zero, L803
	j		 L802
L803:
	la		t1474, L801
	move	$a0, t1474
	jal		tig_print

	move	t1605, $v0
	move	t1476, t1605
L804:
	move	t1478, t1476
L807:
	move	$v0, t1478
	addi	t1606, $sp, 36
	move	$sp, t1606
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

L794:
	li		t1471, 1
	j		L796

L805:
	la		t1472, L797
	move	$a0, t1472
	jal		tig_print

	move	t1607, $v0
	move	$a0, $fp
	li		t1609, 0
	sub		t1608, t1609, t1443
	move	$a1, t1608
	jal		L787

	move	t1610, $v0
	move	t1478, t1610
	j		L807

L798:
	li		t1473, 1
	j		L800

L802:
	move	$a0, $fp
	move	$a1, t1443
	jal		L787

	move	t1611, $v0
	move	t1476, t1611
	j		L804

L847:
L762:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t1485, $a1
	move	$fp, $sp
	addi	t1612, $sp, -8
	move	$sp, t1612
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1613, $sp, -36
	move	$sp, t1613
	move	t1442, t1485
	beq		t1442, $zero, L808
	j		L809
L809:
	li		t1480, 0
L810:
	move	t1483, t1480
	beq		t1483, $zero, L814
	j		 L813
L814:
	lw		$a0, 0($fp)
	lw		$a1, 0(t1442)
	jal		L763

	move	t1614, $v0
	la		t1482, L812
	move	$a0, t1482
	jal		tig_print

	move	t1615, $v0
	lw		$a0, 0($fp)
	lw		$a1, 4(t1442)
	jal		L762

	move	t1616, $v0
	move	t1484, t1616
L815:
	move	$v0, t1484
	addi	t1617, $sp, 36
	move	$sp, t1617
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

L808:
	li		t1480, 1
	j		L810

L813:
	la		t1481, L811
	move	$a0, t1481
	jal		tig_print

	move	t1618, $v0
	move	t1484, t1618
	j		L815

L852:
tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1625, $sp, -8
	move	$sp, t1625
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1626, $sp, -36
	move	$sp, t1626
	addi	t1627, $fp, -8
	move	t1620, t1627
	jal		tig_getchar

	move	t1628, $v0
	move	t1619, t1628
	sw		t1619, 0(t1620)
	move	$a0, $fp
	jal		L765

	move	t1629, $v0
	move	t1487, t1629
	move	$a0, $fp
	jal		L765

	move	t1630, $v0
	move	t1486, t1630
	addi	t1631, $fp, -8
	move	t1622, t1631
	jal		tig_getchar

	move	t1632, $v0
	move	t1621, t1632
	sw		t1621, 0(t1622)
	move	t1624, $fp
	move	$a0, $fp
	move	$a1, t1486
	move	$a2, t1487
	jal		L764

	move	t1633, $v0
	move	t1623, t1633
	move	$a0, t1624
	move	$a1, t1623
	jal		L762

	move	t1634, $v0
	move	$v0, t1634
	addi	t1635, $sp, 36
	move	$sp, t1635
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

L857:

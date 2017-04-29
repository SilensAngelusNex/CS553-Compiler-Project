L679:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1552, $sp, -16
	move	$sp, t1552
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1553, $sp, -36
	move	$sp, t1553
	lw		t1554, 0($fp)
	lw		t1514, -8(t1554)
	li		t1515, 0
L696:
	slt		t1555, t1515, t1514
	beqz	t1555, L680
	j		L697
L680:
	la		t1516, L698
	move	$a0, t1516
	jal		tig_print

	move	t1556, $v0
	move	$v0, t1556
	addi	t1557, $sp, 36
	move	$sp, t1557
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

L697:
	addi	t1558, t1515, 1
	move	t1515, t1558
	lw		t1559, 0($fp)
	lw		t1511, -8(t1559)
	li		t1512, 0
L693:
	slt		t1560, t1512, t1511
	beqz	t1560, L681
	j		L694
L681:
	la		t1513, L695
	move	$a0, t1513
	jal		tig_print

	move	t1561, $v0
	j		L696

L694:
	addi	t1562, t1512, 1
	move	t1512, t1562
	lw		t1504, -8($fp)
	lw		t1563, 0($fp)
	lw		t1505, -16(t1563)
	slt		t1564, t1504, $zero
	beqz	t1564, L682
	j		L683
L683:
	li		$a0, 1
	jal		tig_exit

	move	t1565, $v0
L684:
	li		t1569, 4
	mult	t1504, t1569
	mflo	t1568
	add		t1567, t1568, t1505
	lw		t1566, 0(t1567)
	lw		t1570, -12($fp)
	beq		t1566, t1570, L685
	j		L686
L686:
	li		t1506, 0
L687:
	move	t1509, t1506
	beq		t1509, $zero, L691
	j		 L690
L691:
	la		t1508, L689
	move	t1510, t1508
L692:
	move	$a0, t1510
	jal		tig_print

	move	t1571, $v0
	j		L693

L682:
	lw		t1573, -4(t1505)
	slt		t1572, t1504, t1573
	beqz	t1572, L756
	j		L684
L756:
	j		L683

L685:
	li		t1506, 1
	j		L687

L690:
	la		t1507, L688
	move	t1510, t1507
	j		L692

L755:
L678:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	t1551, $a1
	move	$fp, $sp
	addi	t1574, $sp, -12
	move	$sp, t1574
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1575, $sp, -36
	move	$sp, t1575
	move	t1503, t1551
	lw		t1577, 0($fp)
	lw		t1576, -8(t1577)
	beq		t1503, t1576, L699
	j		L700
L700:
	li		t1517, 0
L701:
	move	t1549, t1517
	beq		t1549, $zero, L753
	j		 L752
L753:
	lw		t1578, 0($fp)
	lw		t1547, -8(t1578)
	li		t1548, 0
L750:
	slt		t1579, t1548, t1547
	beqz	t1579, L702
	j		L751
L702:
	li		t1550, 0
L754:
	move	$v0, t1550
	addi	t1580, $sp, 36
	move	$sp, t1580
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

L699:
	li		t1517, 1
	j		L701

L752:
	lw		$a0, 0($fp)
	jal		L679

	move	t1581, $v0
	move	t1550, t1581
	j		L754

L751:
	addi	t1582, t1548, 1
	move	t1548, t1582
	lw		t1518, -8($fp)
	lw		t1583, 0($fp)
	lw		t1519, -12(t1583)
	slt		t1584, t1518, $zero
	beqz	t1584, L703
	j		L704
L704:
	li		$a0, 1
	jal		tig_exit

	move	t1585, $v0
L705:
	li		t1589, 4
	mult	t1518, t1589
	mflo	t1588
	add		t1587, t1588, t1519
	lw		t1586, 0(t1587)
	beq		t1586, $zero, L706
	j		L707
L707:
	li		t1520, 0
L708:
	move	t1524, t1520
	beq		t1524, $zero, L716
	j		 L715
L716:
	li		t1525, 0
L717:
	move	t1529, t1525
	beq		t1529, $zero, L725
	j		 L724
L725:
	li		t1530, 0
L726:
	move	t1545, t1530
	beq		t1545, $zero, L749
	j		 L748
L749:
	j		L750

L703:
	lw		t1591, -4(t1519)
	slt		t1590, t1518, t1591
	beqz	t1590, L762
	j		L705
L762:
	j		L704

L706:
	li		t1520, 1
	j		L708

L715:
	lw		t1593, -8($fp)
	add		t1592, t1593, t1503
	move	t1521, t1592
	lw		t1594, 0($fp)
	lw		t1522, -20(t1594)
	slt		t1595, t1521, $zero
	beqz	t1595, L709
	j		L710
L710:
	li		$a0, 1
	jal		tig_exit

	move	t1596, $v0
L711:
	li		t1600, 4
	mult	t1521, t1600
	mflo	t1599
	add		t1598, t1599, t1522
	lw		t1597, 0(t1598)
	beq		t1597, $zero, L712
	j		L713
L713:
	li		t1523, 0
L714:
	move	t1525, t1523
	j		L717

L709:
	lw		t1602, -4(t1522)
	slt		t1601, t1521, t1602
	beqz	t1601, L763
	j		L711
L763:
	j		L710

L712:
	li		t1523, 1
	j		L714

L724:
	lw		t1605, -8($fp)
	addi	t1604, t1605, 7
	sub		t1603, t1604, t1503
	move	t1526, t1603
	lw		t1606, 0($fp)
	lw		t1527, -24(t1606)
	slt		t1607, t1526, $zero
	beqz	t1607, L718
	j		L719
L719:
	li		$a0, 1
	jal		tig_exit

	move	t1608, $v0
L720:
	li		t1612, 4
	mult	t1526, t1612
	mflo	t1611
	add		t1610, t1611, t1527
	lw		t1609, 0(t1610)
	beq		t1609, $zero, L721
	j		L722
L722:
	li		t1528, 0
L723:
	move	t1530, t1528
	j		L726

L718:
	lw		t1614, -4(t1527)
	slt		t1613, t1526, t1614
	beqz	t1613, L764
	j		L720
L764:
	j		L719

L721:
	li		t1528, 1
	j		L723

L748:
	lw		t1531, -8($fp)
	lw		t1615, 0($fp)
	lw		t1532, -12(t1615)
	slt		t1616, t1531, $zero
	beqz	t1616, L727
	j		L728
L728:
	li		$a0, 1
	jal		tig_exit

	move	t1617, $v0
L729:
	li		t1620, 4
	mult	t1531, t1620
	mflo	t1619
	add		t1618, t1619, t1532
	li		t1621, 1
	sw		t1621, 0(t1618)
	lw		t1623, -8($fp)
	add		t1622, t1623, t1503
	move	t1533, t1622
	lw		t1624, 0($fp)
	lw		t1534, -20(t1624)
	slt		t1625, t1533, $zero
	beqz	t1625, L730
	j		L731
L731:
	li		$a0, 1
	jal		tig_exit

	move	t1626, $v0
L732:
	li		t1629, 4
	mult	t1533, t1629
	mflo	t1628
	add		t1627, t1628, t1534
	li		t1630, 1
	sw		t1630, 0(t1627)
	lw		t1633, -8($fp)
	addi	t1632, t1633, 7
	sub		t1631, t1632, t1503
	move	t1535, t1631
	lw		t1634, 0($fp)
	lw		t1536, -24(t1634)
	slt		t1635, t1535, $zero
	beqz	t1635, L733
	j		L734
L734:
	li		$a0, 1
	jal		tig_exit

	move	t1636, $v0
L735:
	li		t1639, 4
	mult	t1535, t1639
	mflo	t1638
	add		t1637, t1638, t1536
	li		t1640, 1
	sw		t1640, 0(t1637)
	move	t1537, t1503
	lw		t1641, 0($fp)
	lw		t1538, -16(t1641)
	slt		t1642, t1537, $zero
	beqz	t1642, L736
	j		L737
L737:
	li		$a0, 1
	jal		tig_exit

	move	t1643, $v0
L738:
	addi	t1645, $fp, -8
	lw		t1644, 0(t1645)
	li		t1648, 4
	mult	t1537, t1648
	mflo	t1647
	add		t1646, t1647, t1538
	sw		t1644, 0(t1646)
	lw		$a0, 0($fp)
	addi	t1649, t1503, 1
	move	$a1, t1649
	jal		L678

	move	t1650, $v0
	lw		t1539, -8($fp)
	lw		t1651, 0($fp)
	lw		t1540, -12(t1651)
	slt		t1652, t1539, $zero
	beqz	t1652, L739
	j		L740
L740:
	li		$a0, 1
	jal		tig_exit

	move	t1653, $v0
L741:
	li		t1656, 4
	mult	t1539, t1656
	mflo	t1655
	add		t1654, t1655, t1540
	li		t1657, 0
	sw		t1657, 0(t1654)
	lw		t1659, -8($fp)
	add		t1658, t1659, t1503
	move	t1541, t1658
	lw		t1660, 0($fp)
	lw		t1542, -20(t1660)
	slt		t1661, t1541, $zero
	beqz	t1661, L742
	j		L743
L743:
	li		$a0, 1
	jal		tig_exit

	move	t1662, $v0
L744:
	li		t1665, 4
	mult	t1541, t1665
	mflo	t1664
	add		t1663, t1664, t1542
	li		t1666, 0
	sw		t1666, 0(t1663)
	lw		t1669, -8($fp)
	addi	t1668, t1669, 7
	sub		t1667, t1668, t1503
	move	t1543, t1667
	lw		t1670, 0($fp)
	lw		t1544, -24(t1670)
	slt		t1671, t1543, $zero
	beqz	t1671, L745
	j		L746
L746:
	li		$a0, 1
	jal		tig_exit

	move	t1672, $v0
L747:
	li		t1675, 4
	mult	t1543, t1675
	mflo	t1674
	add		t1673, t1674, t1544
	li		t1676, 0
	sw		t1676, 0(t1673)
	li		t1546, 0
	j		L749

L727:
	lw		t1678, -4(t1532)
	slt		t1677, t1531, t1678
	beqz	t1677, L765
	j		L729
L765:
	j		L728

L730:
	lw		t1680, -4(t1534)
	slt		t1679, t1533, t1680
	beqz	t1679, L766
	j		L732
L766:
	j		L731

L733:
	lw		t1682, -4(t1536)
	slt		t1681, t1535, t1682
	beqz	t1681, L767
	j		L735
L767:
	j		L734

L736:
	lw		t1684, -4(t1538)
	slt		t1683, t1537, t1684
	beqz	t1683, L768
	j		L738
L768:
	j		L737

L739:
	lw		t1686, -4(t1540)
	slt		t1685, t1539, t1686
	beqz	t1685, L769
	j		L741
L769:
	j		L740

L742:
	lw		t1688, -4(t1542)
	slt		t1687, t1541, t1688
	beqz	t1687, L770
	j		L744
L770:
	j		L743

L745:
	lw		t1690, -4(t1544)
	slt		t1689, t1543, t1690
	beqz	t1689, L771
	j		L747
L771:
	j		L746

L761:
tig_main:
	sw		$a0, 0($sp)
	sw		$fp, -4($sp)
	move	$fp, $sp
	addi	t1695, $sp, -28
	move	$sp, t1695
	sw		$s0, 0($sp)
	sw		$s1, -4($sp)
	sw		$s2, -8($sp)
	sw		$s3, -12($sp)
	sw		$s4, -16($sp)
	sw		$s5, -20($sp)
	sw		$s6, -24($sp)
	sw		$s7, -28($sp)
	sw		$ra, -32($sp)
	addi	t1696, $sp, -36
	move	$sp, t1696
	li		t1697, 8
	sw		t1697, -8($fp)
	addi	t1698, $fp, -12
	move	t1691, t1698
	lw		$a0, -8($fp)
	li		$a1, 0
	jal		tig_initArray

	move	t1699, $v0
	move	t1499, t1699
	addi	t1700, t1499, 4
	sw		t1700, 0(t1691)
	addi	t1701, $fp, -16
	move	t1692, t1701
	lw		$a0, -8($fp)
	li		$a1, 0
	jal		tig_initArray

	move	t1702, $v0
	move	t1500, t1702
	addi	t1703, t1500, 4
	sw		t1703, 0(t1692)
	addi	t1704, $fp, -20
	move	t1693, t1704
	lw		t1707, -8($fp)
	lw		t1708, -8($fp)
	add		t1706, t1707, t1708
	addi	t1705, t1706, -1
	move	$a0, t1705
	li		$a1, 0
	jal		tig_initArray

	move	t1709, $v0
	move	t1501, t1709
	addi	t1710, t1501, 4
	sw		t1710, 0(t1693)
	addi	t1711, $fp, -24
	move	t1694, t1711
	lw		t1714, -8($fp)
	lw		t1715, -8($fp)
	add		t1713, t1714, t1715
	addi	t1712, t1713, -1
	move	$a0, t1712
	li		$a1, 0
	jal		tig_initArray

	move	t1716, $v0
	move	t1502, t1716
	addi	t1717, t1502, 4
	sw		t1717, 0(t1694)
	move	$a0, $fp
	li		$a1, 0
	jal		L678

	move	t1718, $v0
	move	$v0, t1718
	addi	t1719, $sp, 36
	move	$sp, t1719
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

L784:

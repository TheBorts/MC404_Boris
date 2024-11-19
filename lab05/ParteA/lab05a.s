	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0"
	.file	"lab05a.c"
	.globl	exit
	.p2align	2
	.type	exit,@function
exit:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	#APP
	mv	a0, a1	# return code
	li	a7, 93	# syscall exit (64) 
	ecall	
	#NO_APP
.Lfunc_end0:
	.size	exit, .Lfunc_end0-exit

	.globl	read
	.p2align	2
	.type	read,@function
read:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 63	# syscall read code (63) 
	ecall		# invoke syscall 
	mv	a3, a0	# move return value to ret_val

	#NO_APP
	sw	a3, -28(s0)
	lw	a0, -28(s0)
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	read, .Lfunc_end1-read

	.globl	write
	.p2align	2
	.type	write,@function
write:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 64	# syscall write (64) 
	ecall	
	#NO_APP
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	write, .Lfunc_end2-write

	.globl	hex_code
	.p2align	2
	.type	hex_code,@function
hex_code:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	sw	a0, -28(s0)
	li	a0, 48
	sb	a0, -23(s0)
	li	a0, 120
	sb	a0, -22(s0)
	li	a0, 10
	sb	a0, -13(s0)
	li	a0, 9
	sw	a0, -36(s0)
	j	.LBB3_1
.LBB3_1:
	lw	a0, -36(s0)
	li	a1, 2
	blt	a0, a1, .LBB3_7
	j	.LBB3_2
.LBB3_2:
	lw	a0, -28(s0)
	andi	a0, a0, 15
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	li	a1, 10
	bltu	a0, a1, .LBB3_4
	j	.LBB3_3
.LBB3_3:
	lw	a0, -32(s0)
	addi	a0, a0, 55
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB3_5
.LBB3_4:
	lw	a0, -32(s0)
	addi	a0, a0, 48
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB3_5
.LBB3_5:
	lw	a0, -28(s0)
	srli	a0, a0, 4
	sw	a0, -28(s0)
	j	.LBB3_6
.LBB3_6:
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -36(s0)
	j	.LBB3_1
.LBB3_7:
	li	a0, 1
	addi	a1, s0, -23
	li	a2, 11
	call	write
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end3:
	.size	hex_code, .Lfunc_end3-hex_code

	.globl	transforma
	.p2align	2
	.type	transforma,@function
transforma:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	sw	a0, -28(s0)
	sw	a0, -32(s0)
	lw	a0, -12(s0)
	lbu	a0, 0(a0)
	li	a1, 45
	bne	a0, a1, .LBB4_2
	j	.LBB4_1
.LBB4_1:
	li	a0, 1
	sw	a0, -32(s0)
	j	.LBB4_2
.LBB4_2:
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB4_3
.LBB4_3:
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 32
	beq	a0, a1, .LBB4_5
	j	.LBB4_4
.LBB4_4:
	lw	a0, -28(s0)
	li	a1, 10
	mul	a1, a0, a1
	lw	a0, -12(s0)
	lw	a2, -24(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	add	a0, a0, a1
	addi	a0, a0, -48
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB4_3
.LBB4_5:
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB4_7
	j	.LBB4_6
.LBB4_6:
	lw	a1, -28(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -28(s0)
	j	.LBB4_7
.LBB4_7:
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	slli	a2, a2, 2
	add	a1, a1, a2
	sw	a0, 0(a1)
	li	a0, 0
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	transforma, .Lfunc_end4-transforma

	.globl	grab_bits
	.p2align	2
	.type	grab_bits,@function
grab_bits:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	lw	a0, -20(s0)
	addi	a0, a0, -1
	sw	a0, -28(s0)
	j	.LBB5_1
.LBB5_1:
	lw	a0, -28(s0)
	li	a1, 0
	blt	a0, a1, .LBB5_4
	j	.LBB5_2
.LBB5_2:
	lw	a0, -24(s0)
	slli	a0, a0, 1
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	a1, -12(s0)
	lw	a2, -16(s0)
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 0(a1)
	lw	a2, -28(s0)
	srl	a1, a1, a2
	andi	a1, a1, 1
	or	a0, a0, a1
	sw	a0, -24(s0)
	j	.LBB5_3
.LBB5_3:
	lw	a0, -28(s0)
	addi	a0, a0, -1
	sw	a0, -28(s0)
	j	.LBB5_1
.LBB5_4:
	lw	a0, -24(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end5:
	.size	grab_bits, .Lfunc_end5-grab_bits

	.globl	main
	.p2align	2
	.type	main,@function
main:
	addi	sp, sp, -80
	sw	ra, 76(sp)
	sw	s0, 72(sp)
	addi	s0, sp, 80
	li	a0, 0
	sw	a0, -12(s0)
	sb	a0, -14(s0)
	lui	a1, 3
	addi	a1, a1, 48
	sh	a1, -16(s0)
	lui	a1, 197379
	addi	a1, a1, 48
	sw	a1, -20(s0)
	sw	a0, -44(s0)
	j	.LBB6_1
.LBB6_1:
	lw	a1, -44(s0)
	li	a0, 4
	blt	a0, a1, .LBB6_4
	j	.LBB6_2
.LBB6_2:
	li	a0, 0
	addi	a1, s0, -20
	sw	a1, -52(s0)
	li	a2, 6
	call	read
	lw	a0, -52(s0)
	lw	a2, -44(s0)
	addi	a1, s0, -40
	call	transforma
	j	.LBB6_3
.LBB6_3:
	lw	a0, -44(s0)
	addi	a0, a0, 1
	sw	a0, -44(s0)
	j	.LBB6_1
.LBB6_4:
	li	a1, 0
	sw	a1, -56(s0)
	sw	a1, -48(s0)
	lw	a3, -48(s0)
	addi	a0, s0, -40
	sw	a0, -60(s0)
	li	a2, 3
	sw	a2, -68(s0)
	call	grab_bits
	mv	a1, a0
	lw	a0, -60(s0)
	sw	a1, -48(s0)
	lw	a3, -48(s0)
	li	a1, 1
	li	a2, 8
	call	grab_bits
	mv	a1, a0
	lw	a0, -60(s0)
	sw	a1, -48(s0)
	lw	a3, -48(s0)
	li	a1, 2
	li	a2, 5
	sw	a2, -64(s0)
	call	grab_bits
	lw	a1, -68(s0)
	lw	a2, -64(s0)
	mv	a3, a0
	lw	a0, -60(s0)
	sw	a3, -48(s0)
	lw	a3, -48(s0)
	call	grab_bits
	mv	a1, a0
	lw	a0, -60(s0)
	sw	a1, -48(s0)
	lw	a3, -48(s0)
	li	a1, 4
	li	a2, 11
	call	grab_bits
	sw	a0, -48(s0)
	lw	a0, -48(s0)
	call	hex_code
	lw	a0, -56(s0)
	lw	ra, 76(sp)
	lw	s0, 72(sp)
	addi	sp, sp, 80
	ret
.Lfunc_end6:
	.size	main, .Lfunc_end6-main

	.globl	_start
	.p2align	2
	.type	_start,@function
_start:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	call	main
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	exit
.Lfunc_end7:
	.size	_start, .Lfunc_end7-_start

	.type	.L__const.main.num,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.num:
	.asciz	"000000"
	.size	.L__const.main.num, 7

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym exit
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym hex_code
	.addrsig_sym transforma
	.addrsig_sym grab_bits
	.addrsig_sym main

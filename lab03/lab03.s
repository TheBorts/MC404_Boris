	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0"
	.file	"lab03.c"
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

	.globl	treat_deci
	.p2align	2
	.type	treat_deci,@function
treat_deci:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	lbu	a0, 0(a0)
	li	a1, 45
	bne	a0, a1, .LBB3_2
	j	.LBB3_1
.LBB3_1:
	li	a0, 1
	sw	a0, -24(s0)
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB3_2
.LBB3_2:
	j	.LBB3_3
.LBB3_3:
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 10
	beq	a0, a1, .LBB3_5
	j	.LBB3_4
.LBB3_4:
	lw	a0, -20(s0)
	li	a1, 10
	mul	a1, a0, a1
	lw	a0, -12(s0)
	lw	a2, -16(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	add	a0, a0, a1
	addi	a0, a0, -48
	sw	a0, -20(s0)
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB3_3
.LBB3_5:
	lw	a0, -24(s0)
	li	a1, 0
	beq	a0, a1, .LBB3_7
	j	.LBB3_6
.LBB3_6:
	lw	a1, -20(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB3_7
.LBB3_7:
	lw	a0, -20(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end3:
	.size	treat_deci, .Lfunc_end3-treat_deci

	.globl	treat_hex
	.p2align	2
	.type	treat_hex,@function
treat_hex:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 2
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB4_1
.LBB4_1:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 10
	beq	a0, a1, .LBB4_3
	j	.LBB4_2
.LBB4_2:
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB4_1
.LBB4_3:
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB4_4
.LBB4_4:
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	bge	a0, a1, .LBB4_7
	j	.LBB4_5
.LBB4_5:
	lw	a1, -12(s0)
	lw	a0, -24(s0)
	lw	a2, -28(s0)
	sub	a0, a0, a2
	add	a0, a0, a1
	lb	a0, 1(a0)
	lw	a1, -16(s0)
	sub	a1, a1, a2
	sb	a0, 7(a1)
	j	.LBB4_6
.LBB4_6:
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB4_4
.LBB4_7:
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	treat_hex, .Lfunc_end4-treat_hex

	.globl	hex_to_bin
	.p2align	2
	.type	hex_to_bin,@function
hex_to_bin:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	sw	a0, -28(s0)
	j	.LBB5_1
.LBB5_1:
	lw	a1, -28(s0)
	li	a0, 31
	blt	a0, a1, .LBB5_4
	j	.LBB5_2
.LBB5_2:
	lw	a0, -16(s0)
	lw	a1, -28(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB5_3
.LBB5_3:
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB5_1
.LBB5_4:
	li	a0, 0
	sw	a0, -32(s0)
	j	.LBB5_5
.LBB5_5:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 10
	beq	a0, a1, .LBB5_18
	j	.LBB5_6
.LBB5_6:
	li	a0, 0
	sw	a0, -36(s0)
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	blt	a0, a1, .LBB5_9
	j	.LBB5_7
.LBB5_7:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a1, 0(a0)
	li	a0, 57
	blt	a0, a1, .LBB5_9
	j	.LBB5_8
.LBB5_8:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -48
	sw	a0, -36(s0)
	j	.LBB5_13
.LBB5_9:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 97
	blt	a0, a1, .LBB5_12
	j	.LBB5_10
.LBB5_10:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a1, 0(a0)
	li	a0, 102
	blt	a0, a1, .LBB5_12
	j	.LBB5_11
.LBB5_11:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -87
	sw	a0, -36(s0)
	j	.LBB5_12
.LBB5_12:
	j	.LBB5_13
.LBB5_13:
	li	a0, 3
	sw	a0, -32(s0)
	j	.LBB5_14
.LBB5_14:
	lw	a0, -32(s0)
	li	a1, 0
	blt	a0, a1, .LBB5_17
	j	.LBB5_15
.LBB5_15:
	lw	a0, -36(s0)
	srli	a1, a0, 31
	add	a1, a0, a1
	andi	a1, a1, 254
	sub	a0, a0, a1
	addi	a0, a0, 48
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	slli	a2, a2, 2
	lw	a3, -32(s0)
	add	a2, a2, a3
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -36(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB5_16
.LBB5_16:
	lw	a0, -32(s0)
	addi	a0, a0, -1
	sw	a0, -32(s0)
	j	.LBB5_14
.LBB5_17:
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB5_5
.LBB5_18:
	lw	a1, -16(s0)
	lw	a0, -20(s0)
	slli	a0, a0, 2
	lw	a2, -32(s0)
	add	a0, a0, a2
	add	a1, a0, a1
	li	a0, 10
	sb	a0, 1(a1)
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end5:
	.size	hex_to_bin, .Lfunc_end5-hex_to_bin

	.globl	num_deci_to_num_decis
	.p2align	2
	.type	num_deci_to_num_decis,@function
num_deci_to_num_decis:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	li	a1, 0
	bge	a0, a1, .LBB6_2
	j	.LBB6_1
.LBB6_1:
	lw	a1, -12(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -12(s0)
	lw	a1, -16(s0)
	li	a0, 45
	sb	a0, 0(a1)
	j	.LBB6_2
.LBB6_2:
	li	a0, 10
	sw	a0, -20(s0)
	j	.LBB6_3
.LBB6_3:
	lw	a1, -12(s0)
	li	a0, 0
	bge	a0, a1, .LBB6_5
	j	.LBB6_4
.LBB6_4:
	lw	a0, -12(s0)
	lui	a1, 419430
	addi	a1, a1, 1639
	mulh	a2, a0, a1
	srli	a3, a2, 31
	srli	a2, a2, 2
	add	a2, a2, a3
	li	a3, 10
	mul	a2, a2, a3
	sub	a0, a0, a2
	addi	a0, a0, 48
	lw	a2, -16(s0)
	lw	a3, -20(s0)
	add	a2, a2, a3
	sb	a0, 0(a2)
	lw	a0, -12(s0)
	mulh	a0, a0, a1
	srli	a1, a0, 31
	srai	a0, a0, 2
	add	a0, a0, a1
	sw	a0, -12(s0)
	lw	a0, -20(s0)
	addi	a0, a0, -1
	sw	a0, -20(s0)
	j	.LBB6_3
.LBB6_5:
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end6:
	.size	num_deci_to_num_decis, .Lfunc_end6-num_deci_to_num_decis

	.globl	num_deci_to_num_bin
	.p2align	2
	.type	num_deci_to_num_bin,@function
num_deci_to_num_bin:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a1, 0
	sw	a1, -20(s0)
	lw	a0, -12(s0)
	bge	a0, a1, .LBB7_2
	j	.LBB7_1
.LBB7_1:
	lw	a1, -12(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -12(s0)
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB7_2
.LBB7_2:
	li	a0, 31
	sw	a0, -24(s0)
	j	.LBB7_3
.LBB7_3:
	lw	a0, -24(s0)
	li	a1, 0
	blt	a0, a1, .LBB7_9
	j	.LBB7_4
.LBB7_4:
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a1, a0, a1
	andi	a1, a1, -2
	sub	a0, a0, a1
	li	a1, 0
	bne	a0, a1, .LBB7_6
	j	.LBB7_5
.LBB7_5:
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB7_7
.LBB7_6:
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB7_7
.LBB7_7:
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -12(s0)
	j	.LBB7_8
.LBB7_8:
	lw	a0, -24(s0)
	addi	a0, a0, -1
	sw	a0, -24(s0)
	j	.LBB7_3
.LBB7_9:
	lw	a0, -20(s0)
	li	a1, 0
	beq	a0, a1, .LBB7_29
	j	.LBB7_10
.LBB7_10:
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB7_11
.LBB7_11:
	lw	a1, -28(s0)
	li	a0, 31
	blt	a0, a1, .LBB7_17
	j	.LBB7_12
.LBB7_12:
	lw	a0, -16(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB7_14
	j	.LBB7_13
.LBB7_13:
	lw	a0, -16(s0)
	lw	a1, -28(s0)
	add	a1, a0, a1
	lb	a0, 0(a1)
	addi	a0, a0, -1
	sb	a0, 0(a1)
	j	.LBB7_15
.LBB7_14:
	lw	a0, -16(s0)
	lw	a1, -28(s0)
	add	a1, a0, a1
	lb	a0, 0(a1)
	addi	a0, a0, 1
	sb	a0, 0(a1)
	j	.LBB7_15
.LBB7_15:
	j	.LBB7_16
.LBB7_16:
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB7_11
.LBB7_17:
	li	a0, 1
	sw	a0, -32(s0)
	li	a0, 31
	sw	a0, -36(s0)
	j	.LBB7_18
.LBB7_18:
	lw	a0, -36(s0)
	li	a1, 0
	blt	a0, a1, .LBB7_28
	j	.LBB7_19
.LBB7_19:
	lw	a0, -16(s0)
	lw	a1, -36(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB7_22
	j	.LBB7_20
.LBB7_20:
	lw	a0, -32(s0)
	li	a1, 1
	bne	a0, a1, .LBB7_22
	j	.LBB7_21
.LBB7_21:
	lw	a0, -16(s0)
	lw	a1, -36(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB7_26
.LBB7_22:
	lw	a0, -16(s0)
	lw	a1, -36(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB7_25
	j	.LBB7_23
.LBB7_23:
	lw	a0, -32(s0)
	li	a1, 1
	bne	a0, a1, .LBB7_25
	j	.LBB7_24
.LBB7_24:
	lw	a0, -16(s0)
	lw	a1, -36(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	li	a0, 0
	sw	a0, -32(s0)
	j	.LBB7_28
.LBB7_25:
	j	.LBB7_26
.LBB7_26:
	j	.LBB7_27
.LBB7_27:
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -36(s0)
	j	.LBB7_18
.LBB7_28:
	j	.LBB7_29
.LBB7_29:
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end7:
	.size	num_deci_to_num_bin, .Lfunc_end7-num_deci_to_num_bin

	.globl	num_deci_to_hex
	.p2align	2
	.type	num_deci_to_hex,@function
num_deci_to_hex:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 8
	sw	a0, -20(s0)
	j	.LBB8_1
.LBB8_1:
	lw	a1, -12(s0)
	li	a0, 0
	bge	a0, a1, .LBB8_6
	j	.LBB8_2
.LBB8_2:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a1, a0, a1
	andi	a1, a1, -16
	sub	a0, a0, a1
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	li	a1, 10
	blt	a0, a1, .LBB8_4
	j	.LBB8_3
.LBB8_3:
	lw	a0, -24(s0)
	lui	a1, 419430
	addi	a1, a1, 1639
	mulh	a1, a0, a1
	srli	a2, a1, 31
	srli	a1, a1, 2
	add	a1, a1, a2
	li	a2, 10
	mul	a1, a1, a2
	sub	a0, a0, a1
	addi	a0, a0, 97
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB8_5
.LBB8_4:
	lw	a0, -24(s0)
	addi	a0, a0, 48
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB8_5
.LBB8_5:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -12(s0)
	j	.LBB8_1
.LBB8_6:
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end8:
	.size	num_deci_to_hex, .Lfunc_end8-num_deci_to_hex

	.globl	hex_to_inv_hex
	.p2align	2
	.type	hex_to_inv_hex,@function
hex_to_inv_hex:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 8
	sw	a0, -20(s0)
	lw	a1, -16(s0)
	li	a0, 10
	sb	a0, 8(a1)
	lw	a0, -12(s0)
	lb	a0, 6(a0)
	lw	a1, -16(s0)
	sb	a0, 0(a1)
	lw	a0, -12(s0)
	lb	a0, 7(a0)
	lw	a1, -16(s0)
	sb	a0, 1(a1)
	lw	a0, -12(s0)
	lb	a0, 4(a0)
	lw	a1, -16(s0)
	sb	a0, 2(a1)
	lw	a0, -12(s0)
	lb	a0, 5(a0)
	lw	a1, -16(s0)
	sb	a0, 3(a1)
	lw	a0, -12(s0)
	lb	a0, 2(a0)
	lw	a1, -16(s0)
	sb	a0, 4(a1)
	lw	a0, -12(s0)
	lb	a0, 3(a0)
	lw	a1, -16(s0)
	sb	a0, 5(a1)
	lw	a0, -12(s0)
	lb	a0, 0(a0)
	lw	a1, -16(s0)
	sb	a0, 6(a1)
	lw	a0, -12(s0)
	lb	a0, 1(a0)
	lw	a1, -16(s0)
	sb	a0, 7(a1)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	hex_to_inv_hex, .Lfunc_end9-hex_to_inv_hex

	.globl	num_bins_to_hex
	.p2align	2
	.type	num_bins_to_hex,@function
num_bins_to_hex:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	j	.LBB10_1
.LBB10_1:
	lw	a1, -20(s0)
	li	a0, 31
	blt	a0, a1, .LBB10_10
	j	.LBB10_2
.LBB10_2:
	li	a0, 0
	sw	a0, -28(s0)
	sw	a0, -32(s0)
	j	.LBB10_3
.LBB10_3:
	lw	a1, -32(s0)
	li	a0, 3
	blt	a0, a1, .LBB10_6
	j	.LBB10_4
.LBB10_4:
	lw	a0, -28(s0)
	slli	a1, a0, 1
	lw	a0, -12(s0)
	lw	a2, -20(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	add	a0, a0, a1
	addi	a0, a0, -48
	sw	a0, -28(s0)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB10_5
.LBB10_5:
	lw	a0, -32(s0)
	addi	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB10_3
.LBB10_6:
	lw	a0, -28(s0)
	li	a1, 10
	blt	a0, a1, .LBB10_8
	j	.LBB10_7
.LBB10_7:
	lw	a0, -28(s0)
	lui	a1, 419430
	addi	a1, a1, 1639
	mulh	a1, a0, a1
	srli	a2, a1, 31
	srli	a1, a1, 2
	add	a1, a1, a2
	li	a2, 10
	mul	a1, a1, a2
	sub	a0, a0, a1
	addi	a0, a0, 65
	lw	a1, -16(s0)
	lw	a2, -24(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB10_9
.LBB10_8:
	lw	a0, -28(s0)
	addi	a0, a0, 48
	lw	a1, -16(s0)
	lw	a2, -24(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB10_9
.LBB10_9:
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB10_1
.LBB10_10:
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end10:
	.size	num_bins_to_hex, .Lfunc_end10-num_bins_to_hex

	.globl	print_bin
	.p2align	2
	.type	print_bin,@function
print_bin:
	addi	sp, sp, -80
	sw	ra, 76(sp)
	sw	s0, 72(sp)
	addi	s0, sp, 80
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -68(s0)
	sb	a0, -14(s0)
	lui	a0, 6
	addi	a0, a0, 560
	sh	a0, -16(s0)
	li	a0, 1
	addi	a1, s0, -16
	li	a2, 2
	call	write
	lw	a0, -68(s0)
	sw	a0, -20(s0)
	j	.LBB11_1
.LBB11_1:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB11_3
	j	.LBB11_2
.LBB11_2:
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB11_1
.LBB11_3:
	li	a0, 0
	sw	a0, -60(s0)
	j	.LBB11_4
.LBB11_4:
	lw	a1, -60(s0)
	li	a0, 32
	blt	a0, a1, .LBB11_7
	j	.LBB11_5
.LBB11_5:
	lw	a1, -60(s0)
	addi	a0, s0, -53
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB11_6
.LBB11_6:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB11_4
.LBB11_7:
	li	a0, 0
	sw	a0, -64(s0)
	j	.LBB11_8
.LBB11_8:
	lw	a0, -64(s0)
	lw	a2, -20(s0)
	li	a1, 33
	sub	a1, a1, a2
	bge	a0, a1, .LBB11_11
	j	.LBB11_9
.LBB11_9:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	lw	a2, -64(s0)
	add	a1, a1, a2
	add	a0, a0, a1
	lb	a0, 0(a0)
	addi	a1, s0, -53
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB11_10
.LBB11_10:
	lw	a0, -64(s0)
	addi	a0, a0, 1
	sw	a0, -64(s0)
	j	.LBB11_8
.LBB11_11:
	lw	a1, -20(s0)
	li	a0, 33
	sub	a2, a0, a1
	li	a0, 1
	addi	a1, s0, -53
	call	write
	lw	ra, 76(sp)
	lw	s0, 72(sp)
	addi	sp, sp, 80
	ret
.Lfunc_end11:
	.size	print_bin, .Lfunc_end11-print_bin

	.globl	print_decis
	.p2align	2
	.type	print_decis,@function
print_decis:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	li	a1, 10
	sb	a1, -18(s0)
	lui	a1, 3
	addi	a1, a1, 48
	sh	a1, -20(s0)
	lui	a1, 197379
	addi	a1, a1, 48
	sw	a1, -24(s0)
	sw	a1, -28(s0)
	sw	a0, -32(s0)
	lw	a0, -12(s0)
	lbu	a0, 0(a0)
	li	a1, 45
	bne	a0, a1, .LBB12_2
	j	.LBB12_1
.LBB12_1:
	li	a0, 45
	sb	a0, -28(s0)
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	lw	a0, -32(s0)
	addi	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB12_2
.LBB12_2:
	j	.LBB12_3
.LBB12_3:
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB12_5
	j	.LBB12_4
.LBB12_4:
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB12_3
.LBB12_5:
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB12_7
	j	.LBB12_6
.LBB12_6:
	lw	a0, -16(s0)
	addi	a0, a0, -1
	sw	a0, -16(s0)
	j	.LBB12_7
.LBB12_7:
	j	.LBB12_8
.LBB12_8:
	lw	a0, -32(s0)
	lw	a2, -16(s0)
	li	a1, 11
	sub	a1, a1, a2
	bge	a0, a1, .LBB12_13
	j	.LBB12_9
.LBB12_9:
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	lw	a2, -32(s0)
	add	a1, a1, a2
	add	a0, a0, a1
	lb	a1, 0(a0)
	addi	a0, s0, -28
	add	a2, a0, a2
	sb	a1, 0(a2)
	lw	a1, -32(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 10
	bne	a0, a1, .LBB12_11
	j	.LBB12_10
.LBB12_10:
	j	.LBB12_13
.LBB12_11:
	j	.LBB12_12
.LBB12_12:
	lw	a0, -32(s0)
	addi	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB12_8
.LBB12_13:
	li	a0, 10
	sb	a0, -18(s0)
	lw	a2, -32(s0)
	li	a0, 1
	addi	a1, s0, -28
	call	write
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end12:
	.size	print_decis, .Lfunc_end12-print_decis

	.globl	bin_to_deci
	.p2align	2
	.type	bin_to_deci,@function
bin_to_deci:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	sw	a0, -28(s0)
	sw	a0, -32(s0)
	j	.LBB13_1
.LBB13_1:
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 10
	beq	a0, a1, .LBB13_3
	j	.LBB13_2
.LBB13_2:
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB13_1
.LBB13_3:
	lw	a0, -12(s0)
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB13_24
	j	.LBB13_4
.LBB13_4:
	lw	a0, -28(s0)
	li	a1, 32
	bne	a0, a1, .LBB13_24
	j	.LBB13_5
.LBB13_5:
	li	a0, 1
	sw	a0, -32(s0)
	li	a0, 0
	sw	a0, -36(s0)
	j	.LBB13_6
.LBB13_6:
	lw	a1, -36(s0)
	li	a0, 31
	blt	a0, a1, .LBB13_12
	j	.LBB13_7
.LBB13_7:
	lw	a0, -12(s0)
	lw	a1, -36(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB13_9
	j	.LBB13_8
.LBB13_8:
	lw	a0, -12(s0)
	lw	a1, -36(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB13_10
.LBB13_9:
	lw	a0, -12(s0)
	lw	a1, -36(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB13_10
.LBB13_10:
	j	.LBB13_11
.LBB13_11:
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB13_6
.LBB13_12:
	li	a0, 1
	sw	a0, -40(s0)
	li	a0, 31
	sw	a0, -44(s0)
	j	.LBB13_13
.LBB13_13:
	lw	a0, -44(s0)
	li	a1, 0
	blt	a0, a1, .LBB13_23
	j	.LBB13_14
.LBB13_14:
	lw	a0, -12(s0)
	lw	a1, -44(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB13_17
	j	.LBB13_15
.LBB13_15:
	lw	a0, -40(s0)
	li	a1, 1
	bne	a0, a1, .LBB13_17
	j	.LBB13_16
.LBB13_16:
	lw	a0, -12(s0)
	lw	a1, -44(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB13_21
.LBB13_17:
	lw	a0, -12(s0)
	lw	a1, -44(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB13_20
	j	.LBB13_18
.LBB13_18:
	lw	a0, -40(s0)
	li	a1, 1
	bne	a0, a1, .LBB13_20
	j	.LBB13_19
.LBB13_19:
	lw	a0, -12(s0)
	lw	a1, -44(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	li	a0, 0
	sw	a0, -40(s0)
	j	.LBB13_23
.LBB13_20:
	j	.LBB13_21
.LBB13_21:
	j	.LBB13_22
.LBB13_22:
	lw	a0, -44(s0)
	addi	a0, a0, -1
	sw	a0, -44(s0)
	j	.LBB13_13
.LBB13_23:
	j	.LBB13_24
.LBB13_24:
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_25
.LBB13_25:
	lw	a1, -48(s0)
	li	a0, 31
	blt	a0, a1, .LBB13_28
	j	.LBB13_26
.LBB13_26:
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	srli	a2, a1, 31
	slli	a0, a0, 1
	or	a0, a0, a2
	slli	a2, a1, 1
	lw	a1, -12(s0)
	lw	a3, -48(s0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	addi	a1, a1, -48
	srai	a3, a1, 31
	add	a0, a0, a3
	add	a1, a2, a1
	sltu	a2, a1, a2
	add	a0, a0, a2
	sw	a1, -24(s0)
	sw	a0, -20(s0)
	j	.LBB13_27
.LBB13_27:
	lw	a0, -48(s0)
	addi	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB13_25
.LBB13_28:
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB13_30
	j	.LBB13_29
.LBB13_29:
	lw	a0, -20(s0)
	lw	a2, -24(s0)
	snez	a1, a2
	add	a0, a0, a1
	li	a1, 0
	sub	a0, a1, a0
	sub	a1, a1, a2
	sw	a1, -24(s0)
	sw	a0, -20(s0)
	j	.LBB13_30
.LBB13_30:
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	sw	a0, 0(a1)
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end13:
	.size	bin_to_deci, .Lfunc_end13-bin_to_deci

	.globl	hexs_to_dec
	.p2align	2
	.type	hexs_to_dec,@function
hexs_to_dec:
	addi	sp, sp, -64
	sw	ra, 60(sp)
	sw	s0, 56(sp)
	addi	s0, sp, 64
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -56(s0)
	j	.LBB14_1
.LBB14_1:
	lw	a1, -56(s0)
	li	a0, 31
	blt	a0, a1, .LBB14_4
	j	.LBB14_2
.LBB14_2:
	lw	a1, -56(s0)
	addi	a0, s0, -49
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB14_3
.LBB14_3:
	lw	a0, -56(s0)
	addi	a0, a0, 1
	sw	a0, -56(s0)
	j	.LBB14_1
.LBB14_4:
	li	a0, 10
	sb	a0, -17(s0)
	lw	a0, -12(s0)
	addi	a1, s0, -49
	sw	a1, -60(s0)
	call	hex_to_bin
	lw	a0, -60(s0)
	lw	a1, -16(s0)
	call	bin_to_deci
	lw	ra, 60(sp)
	lw	s0, 56(sp)
	addi	sp, sp, 64
	ret
.Lfunc_end14:
	.size	hexs_to_dec, .Lfunc_end14-hexs_to_dec

	.globl	print_hex
	.p2align	2
	.type	print_hex,@function
print_hex:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	lui	a0, %hi(.L.str)
	addi	a1, a0, %lo(.L.str)
	li	a0, 1
	li	a2, 2
	call	write
	j	.LBB15_1
.LBB15_1:
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB15_3
	j	.LBB15_2
.LBB15_2:
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB15_1
.LBB15_3:
	li	a0, 10
	sb	a0, -20(s0)
	lui	a0, 197379
	addi	a0, a0, 48
	sw	a0, -24(s0)
	sw	a0, -28(s0)
	li	a0, 0
	sw	a0, -32(s0)
	j	.LBB15_4
.LBB15_4:
	lw	a0, -32(s0)
	lw	a2, -16(s0)
	li	a1, 8
	sub	a1, a1, a2
	bge	a0, a1, .LBB15_9
	j	.LBB15_5
.LBB15_5:
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	lw	a2, -32(s0)
	add	a1, a1, a2
	add	a0, a0, a1
	lb	a1, 0(a0)
	addi	a0, s0, -28
	add	a2, a0, a2
	sb	a1, 0(a2)
	lw	a1, -32(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 10
	bne	a0, a1, .LBB15_7
	j	.LBB15_6
.LBB15_6:
	j	.LBB15_9
.LBB15_7:
	j	.LBB15_8
.LBB15_8:
	lw	a0, -32(s0)
	addi	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB15_4
.LBB15_9:
	lw	a2, -32(s0)
	li	a0, 1
	addi	a1, s0, -28
	call	write
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end15:
	.size	print_hex, .Lfunc_end15-print_hex

	.globl	do_it_hex
	.p2align	2
	.type	do_it_hex,@function
do_it_hex:
	addi	sp, sp, -160
	sw	ra, 156(sp)
	sw	s0, 152(sp)
	addi	s0, sp, 160
	sw	a0, -12(s0)
	li	a0, 10
	sw	a0, -124(s0)
	sb	a0, -16(s0)
	lui	a0, 197379
	addi	a0, a0, 48
	sw	a0, -120(s0)
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	addi	a1, s0, -24
	sw	a1, -128(s0)
	call	treat_hex
	lw	a0, -128(s0)
	addi	a1, s0, -28
	call	hexs_to_dec
	lw	a1, -124(s0)
	lw	a0, -120(s0)
	lw	a2, -28(s0)
	sw	a2, -32(s0)
	sb	a1, -34(s0)
	lui	a1, 3
	addi	a1, a1, 48
	sh	a1, -36(s0)
	sw	a0, -40(s0)
	sw	a0, -44(s0)
	lw	a0, -32(s0)
	addi	a1, s0, -44
	call	num_deci_to_num_decis
	li	a0, 0
	sw	a0, -84(s0)
	j	.LBB16_1
.LBB16_1:
	lw	a1, -84(s0)
	li	a0, 32
	blt	a0, a1, .LBB16_4
	j	.LBB16_2
.LBB16_2:
	lw	a1, -84(s0)
	addi	a0, s0, -77
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB16_3
.LBB16_3:
	lw	a0, -84(s0)
	addi	a0, a0, 1
	sw	a0, -84(s0)
	j	.LBB16_1
.LBB16_4:
	li	a0, 10
	sw	a0, -160(s0)
	sb	a0, -45(s0)
	lw	a0, -32(s0)
	addi	a1, s0, -77
	sw	a1, -148(s0)
	call	num_deci_to_num_bin
	lw	a0, -160(s0)
	sb	a0, -88(s0)
	lui	a0, 197379
	addi	a0, a0, 48
	sw	a0, -156(s0)
	sw	a0, -92(s0)
	sw	a0, -96(s0)
	addi	a0, s0, -24
	sw	a0, -144(s0)
	addi	a1, s0, -96
	sw	a1, -152(s0)
	call	hex_to_inv_hex
	lw	a2, -160(s0)
	lw	a1, -156(s0)
	lw	a0, -152(s0)
	sb	a2, -98(s0)
	lui	a2, 3
	addi	a2, a2, 48
	sh	a2, -100(s0)
	sw	a1, -104(s0)
	sw	a1, -108(s0)
	addi	a1, s0, -112
	call	hexs_to_dec
	lw	a0, -112(s0)
	sw	a0, -116(s0)
	lw	a0, -116(s0)
	addi	a1, s0, -108
	sw	a1, -140(s0)
	call	num_deci_to_num_decis
	lw	a0, -148(s0)
	call	print_bin
	lui	a0, %hi(.L.str.1)
	addi	a1, a0, %lo(.L.str.1)
	sw	a1, -136(s0)
	li	a2, 1
	sw	a2, -132(s0)
	mv	a0, a2
	call	write
	addi	a0, s0, -44
	call	print_decis
	lw	a1, -136(s0)
	lw	a2, -132(s0)
	mv	a0, a2
	call	write
	lw	a0, -144(s0)
	call	print_hex
	lw	a1, -136(s0)
	lw	a2, -132(s0)
	mv	a0, a2
	call	write
	lw	a0, -140(s0)
	call	print_decis
	lw	a1, -136(s0)
	lw	a2, -132(s0)
	mv	a0, a2
	call	write
	lw	ra, 156(sp)
	lw	s0, 152(sp)
	addi	sp, sp, 160
	ret
.Lfunc_end16:
	.size	do_it_hex, .Lfunc_end16-do_it_hex

	.globl	do_it_deci
	.p2align	2
	.type	do_it_deci,@function
do_it_deci:
	addi	sp, sp, -144
	sw	ra, 140(sp)
	sw	s0, 136(sp)
	addi	s0, sp, 144
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	treat_deci
	sw	a0, -16(s0)
	li	a0, 0
	sw	a0, -56(s0)
	j	.LBB17_1
.LBB17_1:
	lw	a1, -56(s0)
	li	a0, 32
	blt	a0, a1, .LBB17_4
	j	.LBB17_2
.LBB17_2:
	lw	a1, -56(s0)
	addi	a0, s0, -49
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB17_3
.LBB17_3:
	lw	a0, -56(s0)
	addi	a0, a0, 1
	sw	a0, -56(s0)
	j	.LBB17_1
.LBB17_4:
	li	a0, 10
	sw	a0, -132(s0)
	sb	a0, -17(s0)
	lw	a0, -16(s0)
	addi	a1, s0, -49
	sw	a1, -120(s0)
	call	num_deci_to_num_bin
	lw	a1, -132(s0)
	lw	a0, -120(s0)
	sb	a1, -60(s0)
	lui	a1, 197379
	addi	a1, a1, 48
	sw	a1, -128(s0)
	sw	a1, -64(s0)
	sw	a1, -68(s0)
	addi	a1, s0, -68
	sw	a1, -116(s0)
	call	num_bins_to_hex
	lw	a2, -132(s0)
	lw	a1, -128(s0)
	lw	a0, -116(s0)
	sb	a2, -72(s0)
	sw	a1, -76(s0)
	sw	a1, -80(s0)
	addi	a1, s0, -80
	sw	a1, -124(s0)
	call	hex_to_inv_hex
	lw	a2, -132(s0)
	lw	a1, -128(s0)
	lw	a0, -124(s0)
	sb	a2, -82(s0)
	lui	a2, 3
	addi	a2, a2, 48
	sh	a2, -84(s0)
	sw	a1, -88(s0)
	sw	a1, -92(s0)
	addi	a1, s0, -96
	call	hexs_to_dec
	lw	a0, -96(s0)
	sw	a0, -100(s0)
	lw	a0, -100(s0)
	addi	a1, s0, -92
	sw	a1, -112(s0)
	call	num_deci_to_num_decis
	lw	a0, -120(s0)
	call	print_bin
	lw	a0, -12(s0)
	call	print_decis
	lui	a0, %hi(.L.str.1)
	addi	a1, a0, %lo(.L.str.1)
	sw	a1, -108(s0)
	li	a2, 1
	sw	a2, -104(s0)
	mv	a0, a2
	call	write
	lw	a0, -116(s0)
	call	print_hex
	lw	a1, -108(s0)
	lw	a2, -104(s0)
	mv	a0, a2
	call	write
	lw	a0, -112(s0)
	call	print_decis
	lw	a1, -108(s0)
	lw	a2, -104(s0)
	mv	a0, a2
	call	write
	lw	ra, 140(sp)
	lw	s0, 136(sp)
	addi	sp, sp, 144
	ret
.Lfunc_end17:
	.size	do_it_deci, .Lfunc_end17-do_it_deci

	.globl	main
	.p2align	2
	.type	main,@function
main:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	li	a0, 0
	sw	a0, -36(s0)
	sw	a0, -12(s0)
	addi	a1, s0, -23
	li	a2, 11
	call	read
	lw	a0, -36(s0)
	sw	a0, -28(s0)
	sw	a0, -32(s0)
	lbu	a0, -23(s0)
	li	a1, 48
	bne	a0, a1, .LBB18_2
	j	.LBB18_1
.LBB18_1:
	li	a0, 1
	sw	a0, -28(s0)
	j	.LBB18_5
.LBB18_2:
	lbu	a0, -23(s0)
	li	a1, 45
	bne	a0, a1, .LBB18_4
	j	.LBB18_3
.LBB18_3:
	li	a0, 1
	sw	a0, -32(s0)
	j	.LBB18_4
.LBB18_4:
	j	.LBB18_5
.LBB18_5:
	lw	a0, -28(s0)
	li	a1, 0
	beq	a0, a1, .LBB18_7
	j	.LBB18_6
.LBB18_6:
	addi	a0, s0, -23
	call	do_it_hex
	j	.LBB18_8
.LBB18_7:
	addi	a0, s0, -23
	call	do_it_deci
	j	.LBB18_8
.LBB18_8:
	li	a0, 0
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end18:
	.size	main, .Lfunc_end18-main

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
.Lfunc_end19:
	.size	_start, .Lfunc_end19-_start

	.type	.L__const.print_bin.out,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.print_bin.out:
	.asciz	"0b"
	.size	.L__const.print_bin.out, 3

	.type	.L__const.print_decis.aux,@object
	.section	.rodata,"a",@progbits
.L__const.print_decis.aux:
	.ascii	"0000000000\n"
	.size	.L__const.print_decis.aux, 11

	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"0x"
	.size	.L.str, 3

	.type	.L__const.print_hex.aux,@object
	.section	.rodata,"a",@progbits
.L__const.print_hex.aux:
	.ascii	"00000000\n"
	.size	.L__const.print_hex.aux, 9

	.type	.L__const.do_it_hex.num_hex,@object
.L__const.do_it_hex.num_hex:
	.ascii	"00000000\n"
	.size	.L__const.do_it_hex.num_hex, 9

	.type	.L__const.do_it_hex.num_decis,@object
.L__const.do_it_hex.num_decis:
	.ascii	"0000000000\n"
	.size	.L__const.do_it_hex.num_decis, 11

	.type	.L__const.do_it_hex.num_inv_hex,@object
.L__const.do_it_hex.num_inv_hex:
	.ascii	"00000000\n"
	.size	.L__const.do_it_hex.num_inv_hex, 9

	.type	.L__const.do_it_hex.num_inv_deci,@object
.L__const.do_it_hex.num_inv_deci:
	.ascii	"0000000000\n"
	.size	.L__const.do_it_hex.num_inv_deci, 11

	.type	.L.str.1,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"\n"
	.size	.L.str.1, 2

	.type	.L__const.do_it_deci.num_hex,@object
	.section	.rodata,"a",@progbits
.L__const.do_it_deci.num_hex:
	.ascii	"00000000\n"
	.size	.L__const.do_it_deci.num_hex, 9

	.type	.L__const.do_it_deci.num_inv_hex,@object
.L__const.do_it_deci.num_inv_hex:
	.ascii	"00000000\n"
	.size	.L__const.do_it_deci.num_inv_hex, 9

	.type	.L__const.do_it_deci.num_inv_deci,@object
.L__const.do_it_deci.num_inv_deci:
	.ascii	"0000000000\n"
	.size	.L__const.do_it_deci.num_inv_deci, 11

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym exit
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym treat_deci
	.addrsig_sym treat_hex
	.addrsig_sym hex_to_bin
	.addrsig_sym num_deci_to_num_decis
	.addrsig_sym num_deci_to_num_bin
	.addrsig_sym hex_to_inv_hex
	.addrsig_sym num_bins_to_hex
	.addrsig_sym print_bin
	.addrsig_sym print_decis
	.addrsig_sym bin_to_deci
	.addrsig_sym hexs_to_dec
	.addrsig_sym print_hex
	.addrsig_sym do_it_hex
	.addrsig_sym do_it_deci
	.addrsig_sym main

.section .data

.section .text
    .globl my_function

    my_function:
        add t1, a0, a1
        addi sp, sp, -20
        sw ra, 0(sp)
        sw a0, 4(sp)
        sw a1, 8(sp)
        sw t1, 12(sp)
        sw a2, 16(sp)
        mv a1, a0
        mv a0, t1
        jal ra, mystery_function
        mv t2, a0
        lw ra, 0(sp)
        lw a0, 4(sp)
        lw a1, 8(sp)
        lw t1, 12(sp)
        lw a2, 16(sp)
        addi sp, sp, 20

        sub t3, a1, t2
        add t4, t3, a2

        addi sp, sp, -32
        sw ra, 0(sp)
        sw a0, 4(sp)
        sw a1, 8(sp)
        sw a2, 12(sp)
        sw t1, 16(sp)
        sw t2, 20(sp)
        sw t3, 24(sp)
        sw t4, 28(sp)
        mv a0, t4
        jal ra, mystery_function
        mv t5, a0
        lw ra, 0(sp)
        lw a0, 4(sp)
        lw a1, 8(sp)
        lw a2, 12(sp)
        lw t1, 16(sp)
        lw t2, 20(sp)
        lw t3, 24(sp)
        lw t4, 28(sp)
        addi sp, sp, 32

        sub t6, a2, t5
        add a0, t4, t6

        ret







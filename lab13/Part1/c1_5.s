.section .data

.section .text
    .globl operation

    operation:
        lw t0, 0(sp)
        lw t1, 4(sp)
        lw t2, 8(sp)
        lw t3, 12(sp)
        lw t4, 16(sp)
        lw t5, 20(sp)

        addi sp, sp, -28
        sw a5, 0(sp)
        sw a4, 4(sp)
        sw a3, 8(sp)
        sw a2, 12(sp)
        sw a1, 16(sp)
        sw a0, 20(sp)
        sw ra, 24(sp)
        mv a0, t5
        mv a1, t4
        mv a2, t3
        mv a3, t2
        mv a4, t1
        mv a5, t0
        mv t0, a6
        mv a6, a7
        mv a7, t0
        jal ra, mystery_function
        lw ra, 24(sp)
        addi sp, sp, 28

        ret




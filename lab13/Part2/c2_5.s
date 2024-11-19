.section .data

.section .text

    .globl node_creation

    node_creation:
        
        addi sp, sp, -8
        
        li t0, 30
        sw t0, 0(sp)
        li t0, 25
        sb t0, 4(sp)
        li t0, 64
        sb t0, 5(sp)
        li t0, -12
        sh t0, 6(sp)

        mv a0, sp

        addi sp, sp, -4
        sw ra, 0(sp)
        jal ra, mystery_function
        lw ra, 0(sp)
        addi sp, sp, 12

        ret

        

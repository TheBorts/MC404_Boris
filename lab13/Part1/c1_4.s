.section .data

.section .text

    .globl operation

    operation:
        add a0, a1, a2
        sub a0, a0, a5
        add a0, a0, a7
        
        lw a1, 0(sp)
        lw a2, 4(sp)
        lw a3, 8(sp)
        lw a4, 12(sp)
        lw a5, 16(sp)
        lw a6, 20(sp)

        add a0, a0, a3
        sub a0, a0, a5

        ret
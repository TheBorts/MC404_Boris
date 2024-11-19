.section .data

.section .text

    .globl middle_value_int
    .globl middle_value_short
    .globl middle_value_char
    .globl value_matrix

    middle_value_int:
        li t0, 2
        div t1, a1, t0
        li t0, 4
        mul t1, t1, t0
        add a0, a0, t1
        lw t0, 0(a0)
        mv a0, t0
        ret

    middle_value_char:
        li t0, 2
        div t1, a1, t0
        li t0, 1
        mul t1, t1, t0
        add a0, a0, t1
        lw t0, 0(a0)
        mv a0, t0
        ret

    middle_value_short:
        li t0, 2
        div t1, a1, t0
        li t0, 2
        mul t1, t1, t0
        add a0, a0, t1
        lw t0, 0(a0)
        mv a0, t0
        ret

    value_matrix:
        li t0, 42
        li t1, 4
        mul t0, t0, t1
        mul t0, a1, t0
        mul a2, a2, t1
        add t0, t0, a2
        add a0, a0, t0
        lw t0, 0(a0)
        mv a0, t0
        ret



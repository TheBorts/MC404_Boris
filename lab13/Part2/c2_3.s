.section .data

.section .text
    .globl fill_array_int
    .globl fill_array_short
    .globl fill_array_char

    fill_array_int:
        li t0, 100
        li t1, 4
        li t2, 0
        
        mul t3, t1, t0
        sub t4, x0, t3
        add sp, sp, t4
        mv t3, sp
        
        1:
            sw t2, 0(t3) 
            addi t2, t2, 1
            addi t3, t3, 4
            bne t0, t2, 1b

        mv t3, sp
        mv a0, t3
        addi sp, sp, -8
        sw ra, 0(sp)
        sw t4, 4(sp)
        jal ra, mystery_function_int
        lw ra, 0(sp)
        lw t4, 4(sp)
        addi sp, sp, 8
        sub sp, sp, t4
        
        ret

    fill_array_short:
        li t0, 100
        li t1, 2
        li t2, 0
        
        mul t3, t1, t0
        sub t4, x0, t3
        add sp, sp, t4
        mv t3, sp
        
        1:
            sw t2, 0(t3) 
            addi t2, t2, 1
            addi t3, t3, 2
            bne t0, t2, 1b

        mv t3, sp
        mv a0, t3
        addi sp, sp, -8
        sw ra, 0(sp)
        sw t4, 4(sp)
        jal ra, mystery_function_short
        lw ra, 0(sp)
        lw t4, 4(sp)
        addi sp, sp, 8
        sub sp, sp, t4
        
        ret

    fill_array_char:
        li t0, 100
        li t1, 1
        li t2, 0
        
        mul t3, t1, t0
        sub t4, x0, t3
        add sp, sp, t4
        mv t3, sp
        
        1:
            sw t2, 0(t3) 
            addi t2, t2, 1
            addi t3, t3, 1
            bne t0, t2, 1b

        mv t3, sp
        mv a0, t3
        addi sp, sp, -8
        sw ra, 0(sp)
        sw t4, 4(sp)
        jal ra, mystery_function_char
        lw ra, 0(sp)
        lw t4, 4(sp)
        addi sp, sp, 8
        sub sp, sp, t4
        
        ret

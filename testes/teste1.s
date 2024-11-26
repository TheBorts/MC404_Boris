.section .data
    my_var: .word 7
    output: .byte 2


.section .text
    
    .globl _start

    _start:
        lw a0, my_var
        addi a0, a0, 48
        sb a0, output, t1
        li a0, 10
        la a1, output
        sb a0, 1(a1)
        jal ra, write
        j exit
    
    
    
    write:    
        li a0, 1            # file descriptor = 1 (stdout)
        la a1, output               # buffer to write the data
        li a2, 2               # size
        li a7, 64           # syscall write (64)
        ecall
        jr ra

    exit:
        li a7, 93
        ecall
        j exit
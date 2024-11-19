.section .data
    input: .space 20
    break: .word 10
    nums: .word 0, 0, 0, 0
    nums_output: .word 0, 0, 0, 0
    output: .space 20

.section .text
    .globl _start

    _start:

        la a1, input #seta o ponteiro para o inicio do buffer
        
        jal ra, read #chama a função de leitura
        
        li t6, 0    #seta o contador de caracteres
        li t5, 4    #seta o maximo de caracteres
        la a2, nums #seta o ponteiro para o inicio do vetor de numeros

        iter_change: #seta o inicio da transformação de caracteres
        
            jal ra, change_to_deci #transforma o byte em decimal

            addi a1, a1, 5
            addi a2, a2, 4
            addi t6, t6, 1

        bne t6, t5, iter_change

        la a1, nums
        
        li t0, 0
        li t5, 4
        la a5, nums_output
        start_sqrt:
            lw a2, 0(a1)
            li t1, 2
            div a0, a2, t1
            li a7, 10
            li a6, 0
                        
            jal ra, apply_iteration

            sw a0, 0(a5)
            addi a5, a5, 4
            addi a1, a1, 4
            addi t0, t0, 1

        bne t0, t5, start_sqrt

        li t0, 0
        li t5, 4
        la a1, nums_output
        la a2, output
        
        start_change:

            jal ra, change_to_string
            addi a1, a1, 4
            addi t0, t0, 1

        bne t0, t5, start_change

        la a1, output
        li a2, 19
        jal ra, write
        
        li a2, 1
        la a1, break
        jal ra, write

        j exit
        
    apply_iteration:
        comeco:
        div a3, a2, a0
        add a3, a3, a0
        div a3, a3, t1
        add a0, x0, a3
        addi a6, a6, 1
        
        bne a6, a7, comeco

        jr ra


    change_to_deci:
        li s3, 10
        
        lb t0, 0(a1)
        addi t1, t0, -48
        
        lb t0, 1(a1)
        mul t1, t1, s3
        addi t2, t0, -48
        add t1, t1, t2
        
        lb t0, 2(a1)
        mul t1, t1, s3
        addi t2, t0, -48
        add t1, t1, t2
        
        lb t0, 3(a1)
        mul t1, t1, s3
        addi t2, t0, -48
        add t1, t1, t2
        
        sw t1, 0(a2)

        jr ra

    change_to_string:

        li s3, 10    
        li t1, 4
        li t2, 0
        addi a2, a2, 3
    
        come_back_here:
            lw t3, 0(a1)
            rem t4, t3, s3
            div t3, t3, s3
            sw t3, 0(a1)
            addi t4, t4, 48
            sb t4, 0(a2)
            addi a2, a2, -1
            addi t2, t2, 1
        
        bne t2, t1, come_back_here

        li t2, 32
        addi a2, a2, 5
        sb t2, 0(a2)
        addi a2, a2, 1

        jr ra


    read:
        li a0, 0  # file descriptor = 0 (stdin)
        # a1: buffer to write the data
        li a2, 20 # size (reads only 1 byte)
        li a7, 63 # syscall read (63)
        ecall
        jr ra

    write:
        li a0, 1            # file descriptor = 1 (stdout)
        addi a1, a1, 0      # buffer
        addi a2, a2, 0      # size
        li a7, 64           # syscall write (64)
        ecall
        jr ra

    exit:
        li a0, 10
        ecall


        
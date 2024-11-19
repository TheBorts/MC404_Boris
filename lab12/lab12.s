.section .data

    byte_test: .byte 0

    string_in: .space 100
    string_in2: .space 100
    string_out: .space 100

.section .text

    .global _start

    _start:
        li t0, 1
        

        jal read
        addi t1, t1, -48
        li t2, 1 
        beq t1, t2, op1 #tries 1
        li t2, 2 
        beq t1, t2, op2 #tries 2
        li t2, 3
        beq t1, t2, op3 #tries 3
        li t2, 4
        beq t1, t2, op4 #tries 4

    op1:
        jal read
        li t2, 10 #newline
        
        loop1:
            jal read
            jal write
            j loop1
        

    op2:
        jal read

        add a2, x0, sp

        loop2:
            jal read
            li t2, 10
            beq t1, t2, reverse
            addi sp, sp, -1
            sb t1, 0(sp)
            j loop2

        reverse:
            lb t1, 0(sp)
            jal write
            addi sp, sp, 1
            beq sp, a2, end_reverse
            j reverse

        end_reverse:
            li t1, 10
            jal write
            j exit



    op3:
        jal read
        
        la t3, string_in

        loop3:
            jal read
            li t2, 10
            sb t1, 0(t3)
            beq t1, t2, end_read_3
            addi t3, t3, 1
            j loop3

        end_read_3:
            sb x0, 0(t3)
            la a0, string_in
            jal atoi
            la a1, string_out
            li a2, 16
            jal itoa

        la t3, string_out

        print_hexa:
            lb t1, 0(t3)
            beqz t1, end_op3
            jal write
            addi t3, t3, 1
            j print_hexa

        end_op3:
            li t1, 10
            jal write
            j exit

    op4:
        jal read

        la t3, string_in

        loop4:
            jal read
            sb t1, 0(t3)
            li t2, 10
            beq t1, t2, end_read_4
            li t2, 32
            beq t1, t2, next_num
            addi t3, t3, 1
            j loop4

        next_num:
            sb x0, 0(t3)
            jal read
            addi a5, t1, 0
            la t3, string_in2
            jal read
            j loop4
        
        end_read_4:
            sb x0, 0(t3)
            la a0, string_in
            jal atoi
            addi s0, a0, 0
            la a0, string_in2
            jal atoi
            addi s1, a0, 0

            li t0, '+'
            beq a5, t0, soma
            li t0, '-'
            beq a5, t0, subtrai
            li t0, '*'
            beq a5, t0, multiplica
            li t0, '/'
            beq a5, t0, divide

        soma:
            add a0, s0, s1
            la a1, string_out
            li a2, 10
            jal itoa
            addi t3, a0, 0
            j print_hexa

        subtrai:
            sub a0, s0, s1
            la a1, string_out
            li a2, 10
            jal itoa
            addi t3, a0, 0
            j print_hexa

        multiplica:
            mul a0, s0, s1
            la a1, string_out
            li a2, 10
            jal itoa
            addi t3, a0, 0
            j print_hexa

        divide:
            div a0, s0, s1
            la a1, string_out
            li a2, 10
            jal itoa
            addi t3, a0, 0
            j print_hexa


    atoi: # a0 = string; a0 = number
        
        add t4, a0, x0
        lbu t1, 0(a0)
        
        li t0, '-'
        beq t1, t0, atoi_neg
        li t0, '+'
        beq t1, t0, atoi_pos

        li t3, 1
        li t0, 0
        j start_atoi

        atoi_neg:
            li t3, -1
            addi a0, a0, 1
            li t0, 0
        j start_atoi

        atoi_pos:
            li t3, 1
            addi a0, a0, 1
            li t0, 0
        j start_atoi
            
        start_atoi:
            lbu t1, 0(a0)
            beqz t1, end_atoi
            li t2, 32
            beq t1, t2, next
        
            li t2, 10
            mul t0, t0, t2
            addi t1, t1, -48
            add t0, t0, t1

            next:
            addi a0, a0, 1
        j start_atoi
    
        end_atoi:
            mul a0, t0, t3
            ret


    itoa: # a0 = number, a1 = string, a2 = base; a0 = string
        
        add t0, a0, x0
        li t1, 0
        add t2, a1, x0
       
        loop_get_size:
            div t0, t0, a2
            addi t1, t1, 1
        bnez t0, loop_get_size
        
        blt a0, x0, itoa_neg
        j itoa_start

        itoa_neg:
            li s0, 16
            beq a2, s0, neg16
            
            li t3, '-'
            sb t3, 0(t2)
            addi t2, t2, 1
            li t0, -1
            mul a0, a0, t0
            j itoa_start

            neg16:
                addi t2, t2, 1
                li t0, 268435455
                add a0, a0, t0
                li t0, 4026531840
                add a0, a0, t0
                li t1, 8

        itoa_start:
            add t5, t1, t2
            addi t1, t1, -1
            add t2, t2, t1
            
            itoa_loop:
                rem t0, a0, a2
                li t3, 9

                bgt t0, t3, do16

                addi t0, t0, 48
                sb t0, 0(t2)
                addi t2, t2, -1
                div a0, a0, a2
                j next_itoa

                do16:
                    addi t0, t0, 55
                    sb t0, 0(t2)
                    addi t2, t2, -1
                    div a0, a0, a2
                j next_itoa

            next_itoa:
            bnez a0, itoa_loop

        end_itoa:
            sb x0, 0(t5)
            add a0, a1, x0
            ret

    read_test:
        li a0, 0
        la a1, byte_test
        li a2, 1
        li a7, 63
        ecall

        lb t1, 0(a1)
        ret

    write_test:
        la a1, byte_test
        sb t1, 0(a1)

        li a0, 1
        li a2, 1
        li a7, 64
        ecall
        ret

    read:
        li s2, 0xFFFF0102
        li s3, 0xFFFF0103

        li t0, 1
        sb t0, 0(s2)
        loop_read:
            lb t0, 0(s2)
            bnez t0, loop_read

        lb t1, 0(s3)
        ret

    write:
        li s4, 0xFFFF0100
        li s6, 0xFFFF0101

        li t0, 1
        sb t1, 0(s6)
        sb t0, 0(s4)
        loop_write:
            lb t0, 0(s4)
            bnez t0, loop_write

        ret    


    exit:
        li a0, 0
        li a7, 93
        ecall

.section .data
    line_break: .byte 10

.section .text
    .global linked_list_search
    .global puts
    .global gets
    .global atoi
    .global itoa
    .global exit

    linked_list_search:
        
        li a2, 0 
        add a3, x0, a1

        search_loop:    
            lw t1, 0(a0)
            lw t2, 4(a0)
            lw t3, 8(a0)

            add t4, t1, t2
            beq t4, a3, found
            beq t3, x0, not_found

            addi a2, a2, 1
            add a0, x0, t3
            j search_loop
            
        found:
            add a0, x0, a2
            jr ra

        not_found:
            li a0, -1
            ret

    puts:

        add a1, a0, x0

        start_puts:
            
            li a0, 1
            li a2, 1
            lb t0, 0(a1)
            
            beqz t0, end_puts
        
            li a7, 64
            ecall
            
            addi a1, a1, 1

            
        j start_puts
        
        end_puts:

            la a1, line_break
            ecall
            ret

    gets:

        add a1, a0, x0
        add t3, x0, a0
        li a2, 1 
        li t0, 10

        start_gets:
            li a0, 0
            li a7, 63
            ecall

            lb t1, 0(a1)
            beq t1, t0, end_gets


            addi a1, a1, 1
        j start_gets

        end_gets:
            sb x0, 0(a1)
            add a0, t3, x0
        ret

    atoi:
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

    itoa:
        

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
            li t3, '-'
            sb t3, 0(t2)
            addi t2, t2, 1
            li t0, -1
            mul a0, a0, t0


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

            

    exit:
        li a0, 0
        li a7, 93
        ecall

.section .data
    num_s: .space 7

    num: .word 0

    out_num: .word 0

    out_num_S: .space 5

    line_break: .byte 10

.section .text
    .global _start

    _start:
        la a1, num_s
        li a2, 7
        jal ra, read

        jal ra, turn_in_num

        jal ra, search

        jal ra, turn_in_string

        addi a5, a5, -1
        jal ra, write_weird

        j exit

    write_weird:
        add s1, x0, ra 
        la a0, out_num_S

        li t1, -2
        beq a5, t1, write_neg
        li a2, 1

        loop_write:
            la a0, out_num_S
            add a1, a5, a0
            jal ra, write
            addi a5, a5, -1
        blt a5, x0, end_write
        j loop_write

        write_neg:
            li a2, 3
            la a1, out_num_S
            jal ra, write
            jr s1

        end_write:
            la a1, line_break
            jal ra, write
            jr s1

    turn_in_string:
        la a0, out_num
        la a1, out_num_S

        li a5, 0
        lw t0, 0(a0)
        bge t0, x0, turn_in_string_loop
        li t1, 45
        sb t1, 0(a1)
        addi a1, a1, 1
        li t1, 49
        sb t1, 0(a1)
        addi a1, a1, 1
        li t1, 10
        sb t1, 0(a1)
        li a5, -1

        
        j end

        turn_in_string_loop:
            li t1, 10
            rem t2, t0, t1
            addi t2, t2, 48
            sb t2, 0(a1)
            addi a1, a1, 1
            addi a5, a5, 1
            div t0, t0, t1
            beq t0, x0, end_string_loop
            j turn_in_string_loop

        end_string_loop:
            li t1, 10
            sb t1, 0(a1)
            jr ra

    search:
        la a0, head_node
        
        li a1, 0
        lw a3, num


        search_loop:    
            lw t1, 0(a0)
            lw t2, 4(a0)
            lw t3, 8(a0)

            add t4, t1, t2
            beq t4, a3, found
            beq t3, x0, not_found

            addi a1, a1, 1
            add a0, x0, t3
            j search_loop
            
        found:
            la t6, out_num
            sw a1, 0(t6)
            jr ra

        not_found:
            li a1, -1
            la t6, out_num
            sw a1, 0(t6)
            jr ra


    turn_in_num:
        la a0, num
        la a1, num_s

        li t1, 1 # neg
        lb t0, 0(a1)
        li t2, 45 # '-'
        bne t0, t2, do
        li t1, -1
        addi a1, a1, 1

        do:
            li t0, 0
            li t2, 10
            li t3, 0
            li t4, 0
            li t5, -48

            turn_in_num_loop:
                lb t0, 0(a1)
                beq t0, t2, end
                add t0, t0, t5
                mul t3, t3, t2
                add t3, t3, t0
                addi a1, a1, 1
                j turn_in_num_loop

            end:
                mul t3, t3, t1
                sw t3, 0(a0)
                jr ra        

    read:
        # a0 file descriptor
        # a1 address to store the read data
        # a2 number of bytes to read
        li a7, 63            # syscall read
        ecall
        jr ra

    write:
        li a0, 1            # file descriptor = 1 (stdout)
        # a1:               # buffer to write the data
        # a2:               # size
        li a7, 64           # syscall write (64)
        ecall
        jr ra

    exit:
        li a0, 0
        li a7, 93
        ecall


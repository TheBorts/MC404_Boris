.section .data
    #Aqui vai ter Yb e Xc
    input_1: .space 12

    #aqui vai ter Ta, Tb, Tc, Tr
    input_2: .space 20

    #Aqui vai ter Yb e Xc
    nums_1: .word 0, 0
    
    #aqui vai ter Ta, Tb, Tc, Tr
    nums_2: .word 0, 0, 0, 0
    
    #aqui vai ter da, db, dc
    nums_3: .word 0, 0, 0

    #Aqui vai ter X e Y
    #y = (da^2 + Yb^2 - db^2)/(2 * Yb)
    #x = (da^2 + Xc^2 - dc^2)/(2 * Xc)
    nums_output: .word 0, 0

    output: .space 12


.section .text
    .globl _start

    _start:
        la a1, input_1
        li a2, 12
        jal ra, read

        la a0, nums_1
        la a1, input_1
        jal ra, turn_in_num

        la a1, input_2
        li a2, 20
        jal ra, read

        la a0, nums_2
        la a1, input_2
        jal ra, turn_in_num

        la a0, nums_2
        la a1, nums_3
        jal ra, convert_time_meters

        la a0, nums_1
        la a1, nums_3
        la a2, nums_output
        jal ra, calc_xy

        la a0, output
        la a1, nums_output
        jal ra, convert_num_to_string

        la a1, output
        li t0, 10
        li a2, 12
        sb t0, 11(a1)
        jal ra, write

        j exit

        

    calc_xy:
        #a0 -> nums_1
        #a1 -> nums_3
        #a2 -> nums_output
        #y = (da^2 + Yb^2 - db^2)/(2 * Yb)
        #x = (da^2 + Xc^2 - dc^2)/(2 * Xc)

        lw t0, 0(a0) #Yb
        lw t1, 4(a0) #Xc
        lw t2, 0(a1) #da
        lw t3, 4(a1) #db
        lw t4, 8(a1) #dc

        mul t5, t2, t2
        mul t6, t0, t0
        add t5, t5, t6
        mul t6, t3, t3
        sub t5, t5, t6
        add t0, t0, t0
        div t5, t5, t0
        sw t5, 4(a2)

        mul t5, t2, t2
        mul t6, t1, t1
        add t5, t5, t6
        mul t6, t4, t4
        sub t5, t5, t6
        add t1, t1, t1
        div t5, t5, t1
        sw t5, 0(a2)        

        jr ra


    convert_num_to_string:
        #a0->output
        #a1->nums_output
        li t5, 2
        li t0, 10

        begin:
        li t1, 4
        lw t2, 0(a1)
        
        blt t2, x0, negative1

        positive1:
            li t6, 43
            sb t6, 0(a0)
            addi a0, a0, 4
            j convert_num

        negative1:
            li t6, 45
            sb t6, 0(a0)
            addi a0, a0, 4
            li t6, -1
            mul t2, t2, t6
        
        convert_num:
            rem t3, t2, t0
            div t2, t2, t0
            addi t3, t3, 48
            sb t3, 0(a0)
            addi a0, a0, -1
            addi t1, t1, -1
        bne t1, x0, convert_num

        addi t5, t5, -1
        li t1, 32
        addi a0, a0, 5
        sb t1, 0(a0)
        addi a0, a0, 1
        addi a1, a1, 4
        
        bne t5, x0, begin

        addi a0, a0, -1
        li t1, 10
        sb t1, 0(a0)

        jr ra

    convert_time_meters:
        #a0 -> nums_2
        #a1 -> nums_3

        li t6, 10
        li t5, 3

        lw t0, 0(a0)
        lw t1, 12(a0)

        sub t2, t0, t1
        mul t2, t2, t5
        div t2, t2, t6

        sw t2, 0(a1)

        
        lw t0, 4(a0)

        sub t2, t0, t1
        mul t2, t2, t5
        div t2, t2, t6

        sw t2, 4(a1)

        
        lw t0, 8(a0)

        sub t2, t0, t1
        mul t2, t2, t5
        div t2, t2, t6

        sw t2, 8(a1)

        jr ra


    turn_in_num:
        #a0->output
        #a1->input
        # 43 = +
        # 45 = -
        # 32 = space
        
        li t1, 10
        li t4, 0
        li t6, 1
        lb t2, 0(a1)

        start_conversion:
            lb t2, 0(a1)

            li t5, 43
            beq t2, t5, positive
            
            li t5, 45
            beq t2, t5, negative

            li t5, 10
            beq t2, t5, end
            
            li t5, 32
            beq t2, t5, next_num
            
            j end_signal

            negative:
                li t6, -1
                addi a1, a1, 1
                j end_signal
            
            positive:
                li t6, 1
                addi a1, a1, 1
                j end_signal

            end_signal:
                lb t2, 0(a1)
                addi t2, t2, -48
                mul t4, t4, t1
                mul t2, t2, t6
                add t4, t4, t2
                addi a1, a1, 1
            j start_conversion
                
            next_num:
                addi a1, a1, 1
                sw t4, 0(a0)
                addi a0, a0, 4
            j turn_in_num
            
            end:
                sw t4, 0(a0)
    jr ra

    read:
        li a0, 0  # file descriptor = 0 (stdin)
        # a1: buffer to write the data
        # a2: size (reads only 1 byte)
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
        li a0, 0
        li a7, 93
        ecall


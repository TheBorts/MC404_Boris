.section .data
    bits_s: .space 5
    cod_bits_s: .space 8
    
    cod_out_bits: .byte 0, 0, 0, 0, 0, 0, 0, 0
    decoded_out_bits: .byte 0, 0, 0, 0, 0
    aux_cod_bits: .byte 0, 0, 0, 0, 0, 0, 0, 0
    out_byte: .byte 0, 10


.section .text  

    .globl _start   


    _start:
        la a1, bits_s
        li a2, 5
        jal ra, read

        la a1, cod_bits_s
        li a2, 8
        jal ra, read

        la a1, bits_s
        la a0, cod_out_bits
        jal ra, encode
        addi a1, a0, 0
        li a2, 8
        jal ra, write

        la a1, cod_bits_s
        la a0, decoded_out_bits
        jal ra, decode
        addi a1, a0, 0
        li a2, 5
        jal ra, write

        la a1, decoded_out_bits
        la a0, aux_cod_bits
        jal ra, encode
        la a0, out_byte
        la a1, aux_cod_bits
        la a2, cod_bits_s
        jal ra, compare

        la a1, out_byte
        li a2, 2
        jal ra, write

        j exit


    compare:
        #a0 -> output (0 if equal, 1 if not)
        #a1 -> address of string to compare
        #a2 -> address of string to compare

        li t4, 0
        li t0, 0
        li t1, 8

        compare_loop:
            lb t2, 0(a1)
            lb t3, 0(a2)

            beq t2, t3, compare_equal
            addi t4, t4, 1
            j out

            compare_equal:
                addi a1, a1, 1
                addi a2, a2, 1
                addi t0, t0, 1

            bne t1, t0, compare_loop
        
        out:
            addi t4, t4, 48
            sb t4, 0(a0)
            jr ra

    decode:
        #a1 -> address of coded bits
        #a0 -> address of output bits

        lb t0, 2(a1)
        sb t0, 0(a0)

        lb t0, 4(a1)
        sb t0, 1(a0)

        lb t0, 5(a1)
        sb t0, 2(a0)

        lb t0, 6(a1)
        sb t0, 3(a0)

        li t0, 10
        sb t0, 4(a0)

        jr ra

    encode:
        #a1 -> address of bits
        #a0 -> address of out_bits
        #size = 4

        #quant bits
        li t1, 0
        li t2, 0
        li t3, 0
        
        #loads byte
        lb t0, 0(a1)
        addi t0, t0, -48

        #sums parity
        add t1, t1, t0
        add t2, t2, t0

        #loads byte
        lb t0, 1(a1)
        addi t0, t0, -48

        add t1, t1, t0
        add t3, t3, t0

        #loads byte
        lb t0, 2(a1)
        addi t0, t0, -48

        add t2, t2, t0
        add t3, t3, t0

        #loads byte
        lb t0, 3(a1)
        addi t0, t0, -48

        add t1, t1, t0
        add t2, t2, t0
        add t3, t3, t0
        
        li t4, 2
        #calculates parity
        rem t1, t1, t4
        rem t2, t2, t4
        rem t3, t3, t4

        #turns into char
        addi t1, t1, 48
        addi t2, t2, 48
        addi t3, t3, 48

        #encodes it
        sb t1, 0(a0)
        sb t2, 1(a0)

        lb t1, 0(a1)
        sb t1, 2(a0)

        sb t3, 3(a0)

        lb t1, 1(a1)
        sb t1, 4(a0)

        lb t1, 2(a1)
        sb t1, 5(a0)

        lb t1, 3(a1)
        sb t1, 6(a0)

        li t1, 10
        sb t1, 7(a0)

        jr ra



    read:
        li a0, 0  # file descriptor = 0 (stdin)
        # a1: buffer to write the data
        # a2: size
        li a7, 63 # syscall read (63)
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
        li a0, 10
        ecall
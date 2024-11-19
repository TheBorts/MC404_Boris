.section .data

    # image file path
    input_file: .asciz "image.pgm"
    fd_: .word 0

    # image data
    s_id_image: .space 3


    # image X and Y
    nums_size: .word 0, 0

    bytezao: .byte 0

    image: .space 263000

.section .text
    .globl _start


    _start:
        # open the file
        jal ra, openFile
        la a1, fd_
        sw a0, 0(a1)


        # read the image size id
        lw a0, fd_
        la a1, s_id_image
        li a2, 3
        jal ra, read

        # read the image size
        jal ra, turn_in_num

        # read max val
        jal ra, read_byte
        jal ra, read_byte
        jal ra, read_byte
        jal ra, read_byte

        # seta o tamanho do canva
        jal ra, set_canva_size

        # get pixels
        lw a0, fd_
        la a1, image
        li a2, 263000
        jal ra, read
        jal ra, do_pixels

        jal ra, exit        


    set_canva_size:
        la t0, nums_size
        lw a0, 0(t0)
        lw a1, 4(t0)
        li a7, 2201
        ecall
        jr ra

    do_pixels:

        la a0, nums_size
        addi s1, ra, 0

        lw t2, 0(a0) # max x
        lw t3, 4(a0) # max y

        li t0, 0 # x
        li t1, 0 # y
        li t4, 256

        loop_Y:
            
            loop_X:
                
                la s2, image
                mul s3, t1, t2
                add s2, s2, s3
                add s2, s2, t0
                li a3, 0



                beq t0, x0, do
                addi a2, t2, -1
                beq t0, a2, do

                beq t1, x0, do
                addi a2, t3, -1
                beq t1, a2, do

                lbu a3, 0(s2)
                li a2, 8
                mul a3, a3, a2
                sub s2, s2, t2
                lbu a4, -1(s2)
                sub a3, a3, a4
                lbu a4, 0(s2)
                sub a3, a3, a4
                lbu a4, 1(s2)
                sub a3, a3, a4
                add s2, s2, t2
                lbu a4, -1(s2)
                sub a3, a3, a4
                lbu a4, 1(s2)
                sub a3, a3, a4
                add s2, s2, t2
                lbu a4, -1(s2)
                sub a3, a3, a4
                lbu a4, 0(s2)
                sub a3, a3, a4
                lbu a4, 1(s2)
                sub a3, a3, a4

                li a4, 255
                blt a3, a4, next
                li a3, 255
                j do

                next:    
                blt x0, a3, do
                li a3, 0


                do:
                    add a2, x0, a3
                    mul a2, a2, t4
                    add a2, a2, a3
                    mul a2, a2, t4
                    add a2, a2, a3
                    mul a2, a2, t4
                    addi a2, a2, 255

                    add a0, t0, x0 # seta x
                    add a1, t1, x0 # seta y

                    jal ra, setPixel

                    addi t0, t0, 1

            bne t0, t2, loop_X

            addi t1, t1, 1
            li t0, 0

        bne t1, t3, loop_Y
    
    jr s1

    turn_in_num:

        add s0, x0, ra
        li t0, 0
        li t3, 10

        loop_2:
        
            jal ra, read_byte
            lb t1, bytezao
            li t2, 0

            loop_1:
        
                mul t2, t2, t3
                addi t1, t1, -48
                add t2, t2, t1
                jal ra, read_byte
                lb t1, bytezao

            li t6, 10
            beq t1, t6, exit1

            li t6, 32
            bne t1, t6, loop_1    
            
            exit1:
            
            la a0, nums_size
            add a0, a0, t0
            sw t2, 0(a0)
            addi t0, t0, 4
        
        li t6, 8
        bne t0, t6, loop_2

    jr s0

    openFile:
        la a0, input_file    # address for the file path
        li a1, 0             # flags (0: rdonly, 1: wronly, 2: rdwr)
        li a2, 0             # mode
        li a7, 1024          # syscall open
        ecall
        jr ra

    closeFile:
        li a0, 0             # file descriptor
        li a7, 57            # syscall close
        ecall
        jr ra

    setPixel:    
        # a0:  x coordinate
        # a1:  y coordinate
        # a2:  color value
        li a7, 2200 # syscall setPixel (2200)
        ecall
        jr ra

    read_byte:
        lw a0, fd_ # file descriptor
        la a1, bytezao # address to store the read data
        li a2, 1 # read one byte
        li a7, 63 # syscall read
        ecall
        jr ra

    read:
        # a0 file descriptor
        # a1 address to store the read data
        # a2 number of bytes to read
        li a7, 63            # syscall read
        ecall
        jr ra

    exit:
        li a0, 0
        li a7, 93
        ecall

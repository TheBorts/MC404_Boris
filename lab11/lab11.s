.section .text
    .globl _start

    _start:
        li t0, 0xFFFF0100

        addi t1, t0, 0x20
        li t2, -68 #mudar aqui a rotação
        sb t2, 0(t1)

        addi t1, t0, 0x21
        li t2, 1 #seta pra frente
        sb t2, 0(t1)

        li t3, 15000 #mudar aqui o tempo
        1:
            addi t3, t3, -1
            bnez t3, 1b


        li t3, 2000 #mudar aqui o tempo de break
        1:
            addi t3, t3, -1
            bnez t3, 1b

        addi t1, t0, 0x22
        li t2, 1 #seta freio de mao
        sb t2, 0(t1)

        exit:
            li a0, 0
            li a7, 93
            ecall


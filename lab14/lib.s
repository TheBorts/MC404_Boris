.section .bss
    .align 4

    .globl stack_pointer_end
    stack_pointer:
    .skip 1024
    stack_pointer_end:


    .globl isr_stack_end
    isr_stack: 
    .skip 1024
    isr_stack_end:

.section .data

    .align 2

    .globl _system_time
    _system_time: .word 0

.section .text

    .globl _start
    .globl play_note // void play_note(int ch, int inst, int note, int vel, int dur)
    .globl main_isr



    _start:

        la t0, isr_stack_end
        csrw mscratch, t0

        la sp, stack_pointer_end

        la t0, main_isr
        csrw mtvec, t0

        csrr t0, mie
        li t1, 0x800
        or t0, t0, t1
        csrw mie, t0

        csrr t0, mstatus
        li t1, 0x8
        or t0, t0, t1
        csrw mstatus, t0

        li t0, 0xFFFF0100
        li t1, 100
        sw t1, 8(t0)
        li t1, 1
        sw t1, 0(t0)
        1:
            lw t1, 0(t0)
        bnez t1, 1b

        jal ra, main

        j exit

    main_isr:
        csrrw sp, mscratch, sp
        addi sp, sp, -32
        sw a0, 28(sp)
        sw a1, 24(sp)
        sw t0, 20(sp)
        sw t1, 16(sp)
        

        
        li t0, 0xFFFF0100
        li t1, 100
        sw t1, 8(t0)
        li t1, 1
        sw t1, 0(t0)
        1:
            lw t1, 0(t0)
        bnez t1, 1b
        
        la a0, _system_time
        lw a1, 0(a0)
        addi a1, a1, 100
        sw a1, 0(a0)
        
        
        lw a0, 28(sp)
        lw a1, 24(sp)
        lw t0, 20(sp)
        lw t1, 16(sp)

        addi sp, sp, 32
        csrrw sp, mscratch, sp



        mret

    play_note:
        li t0, 0xFFFF0300
        sh a1, 2(t0)
        sb a2, 4(t0)
        sb a3, 5(t0)
        sh a4, 6(t0)
        sb a0, 0(t0)
        
        ret

    exit: 
        li a0, 0
        li a7, 93
        ecall
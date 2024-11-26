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

.section .text

    .align 4
    
    .globl _start
    .globl control_logic

    # syscall_set_engine_and_steering Code: 10

    # syscall_set_hand_brake Code: 11
    #'a0: hand_brake (0: off, 1: on)


    int_handler:
        ###### Syscall and Interrupts handler ######

        # <= Implement your syscall handler here
        csrrw sp, mscratch, sp
        addi sp, sp, -32
        sw a0, 28(sp)
        sw a1, 24(sp)
        sw t0, 20(sp)
        sw t1, 16(sp)
        sw a7, 12(sp)
        
        li t0, 10
        beq a7, t0, syscall_set_engine_and_steering
        li t0, 11
        beq a7, t0, syscall_set_hand_brake
        li t0, 15
        beq a7, t0, syscall_get_position


        # a0: engine (-1: back, 0: off, 1: on)
        # a1: steering (-127: left, 0: straight, 127: right)
        syscall_set_engine_and_steering:
            li t0, 0xFFFF0100
            sb a1, 0x20(t0)
            sb a0, 0x21(t0)
            
            j exit

        # a0: hand_brake (0: off, 1: on)
        syscall_set_hand_brake:
            li t0, 0xFFFF0100
            sb a0, 0x22(t0)

        # a0: x
        # a1: y
        # a2: z
        syscall_get_position:

            li t0, 0xFFFF0100
            li t1, 1

            sb t1, 0(t0)

            1:
                lw t1, 0(t0)
            bnez t1, 1b
    
            lw a0, 10(t0)
            lw a1, 14(t0)
            lw a2, 18(t0)
            j exit2

        exit:
        lw a0, 28(sp)
        lw a1, 24(sp)
        
        exit2:
        lw t0, 20(sp)
        lw t1, 16(sp)
        lw a7, 12(sp)


        csrr t0, mepc  # load return address (address of
                       # the instruction that invoked the syscall)
        addi t0, t0, 4 # adds 4 to the return address (to return after ecall)
        csrw mepc, t0  # stores the return address back on mepc
        mret           # Recover remaining context (pc <- mepc)

    _start:

        la t0, int_handler  # Load the address of the routine that will handle interrupts
        csrw mtvec, t0      # (and syscalls) on the register MTVEC to set
                            # the interrupt array.

        la t0, isr_stack_end
        csrw mscratch, t0

        la sp, stack_pointer_end

        la t0, int_handler
        csrw mtvec, t0

        # Enable machine interrupts
        csrr t0, mie
        li t1, 0x800
        or t0, t0, t1
        csrw mie, t0

        # Enable interrupts
        csrr t0, mstatus
        li t1, 0x8
        or t0, t0, t1
        csrw mstatus, t0

        # Write here the code to change to user mode and call the function
        # user_main (defined in another file). Remember to initialize
        # the user stack so that your program can use it.

        # change to user mode

        # set mepc to user_main and mstatus to user mode
        csrr t1, mstatus
        li t2, ~0x1800
        and t1, t1, t2
        csrw mstatus, t1

        la t0, user_main
        csrw mepc, t0

        mret

    control_logic:
        # implement your control logic here, using only the defined syscalls
        li a0, 1
        li a1, -16
        li a7, 10
        ecall

        wait:
            li a7, 15
            ecall
            li t0, 112
            li t1, 4
            li t2, -15
            blt a0, t0, wait
            blt a1, t1, wait
            blt a2, t2, wait
            li t0, 106
            li t1, 0
            li t2, -30
            bgt a0, t0, wait
            bgt a1, t1, wait
            bgt a2, t2, wait
        
        break:
            li a0, -1
            li a1, 0
            li a7, 10
            ecall 
            
            li a0, 1
            li a7, 11
            ecall

        
        


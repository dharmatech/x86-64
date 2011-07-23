
        .include "utils.s"
        
        global_text main
        
        prepare_stack

        .set offset , 0

        stack_allocate ARGV , 8
        stack_allocate A    , 8
        stack_allocate B    , 8
        stack_allocate C    , 8

        mov %rsi , ARGV(%rbp)

        ref8 ARGV , 1 , %rdi ; call atoi ; mov %rax , A(%rbp)
        ref8 ARGV , 2 , %rdi ; call atoi ; mov %rax , B(%rbp)

        mov A(%rbp) , %rax
        mov B(%rbp) , %rcx

        add %rcx , %rax
        
        mov %rax , C(%rbp)

        print_int C(%rbp)

        print_nl

        mov $0 , %rax

        leave
        ret

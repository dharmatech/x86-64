
        .include "utils-a.s"

        global_text main

        prepare_stack

        .set offset , 0

        stack_allocate ARGV , 8
        stack_allocate A    , 8
        stack_allocate B    , 8
        stack_allocate C    , 8

        mov %rsi , ARGV(%rbp)

        ref8 ARGV , 1 , %rdi ; call atof ; movsd %xmm0 , A(%rbp)
        ref8 ARGV , 2 , %rdi ; call atof ; movsd %xmm0 , B(%rbp)

        movsd A(%rbp) , %xmm0
        movsd B(%rbp) , %xmm1
        
        call atan2

        movsd %xmm0 , C(%rbp)

        print_double C(%rbp)
        
        print_nl

        return_integer $0
        

        
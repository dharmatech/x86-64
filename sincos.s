
        .include "utils.s"

        global_text main

        prepare_stack

        .set offset , 0

        stack_allocate ARGV , 8
        stack_allocate A    , 8
        stack_allocate B    , 8
        stack_allocate C    , 8

        mov %rsi , ARGV(%rbp)

        ref8 ARGV , 1 , %rdi
        call atof ;
        movsd %xmm0 , A(%rbp)

        movsd A(%rbp) , %xmm0
        lea   B(%rbp) , %rdi
        lea   C(%rbp) , %rsi

        call sincos

        print_double B(%rbp)
        print_literal_string " "
        print_double C(%rbp)
        
        print_nl

        return_integer $0

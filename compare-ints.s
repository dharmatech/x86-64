
        .include "utils.s"
        
        global_text main

        prepare_stack

        .set offset , 0

        stack_allocate ARGV , 8
        stack_allocate A    , 8
        stack_allocate B    , 8
        stack_allocate TMP  , 8

        mov %rsi , ARGV(%rbp)

        ref8 ARGV , 1 , %rdi ; call atoi ; mov %rax , A(%rbp)
        ref8 ARGV , 2 , %rdi ; call atoi ; mov %rax , B(%rbp)

        mov A(%rbp) , %r10
        mov B(%rbp) , %r11

        cmp %r11 , %r10

        jg 1f
        jl 2f
        je 3f

1:     
        print_literal_string "greater than\n"
        jmp 4f
2:
        print_literal_string "less than\n"
        jmp 4f
3:
        print_literal_string "equal\n"
        jmp 4f
4:

        return_integer $0

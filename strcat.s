
        .include "utils.s"

        global_text main

        prepare_stack

        .set offset , 0

        stack_allocate ARGV , 8
        stack_allocate DATA , 8

        mov %rsi , ARGV(%rbp)
        
        mov $1000 , %rdi

        call malloc ; mov %rax , DATA(%rbp)

        set1 $0 , DATA , 0

        mov DATA(%rbp) , %rdi ; ref8 ARGV , 1 , %rsi ; call strcat
        mov DATA(%rbp) , %rdi ; ref8 ARGV , 2 , %rsi ; call strcat

        print_string DATA(%rbp)
        print_nl

        return_integer $0

        
        

        
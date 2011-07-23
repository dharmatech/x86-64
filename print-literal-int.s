
        .include "utils.s"
        
        global_text main

        prepare_stack

        mov $123 , %rax

        print_int %rax

        print_nl

        return_integer $0

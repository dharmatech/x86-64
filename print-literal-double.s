
        .include "utils.s"
        
        global_text main

        prepare_stack

        literal_double 0e1.2 %xmm0

        print_double %xmm0

        print_nl

        return_integer $0

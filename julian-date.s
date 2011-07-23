
        .include "utils.s"
        
        global_text main

        prepare_stack

        .set offset , 0

        stack_allocate ARGV , 8
        stack_allocate Y    , 8
        stack_allocate M    , 8
        stack_allocate D    , 8
        stack_allocate A    , 8
        stack_allocate B    , 8
        stack_allocate C    , 8
        stack_allocate E    , 8
        stack_allocate RES  , 16

        mov %rsi , ARGV(%rbp)

        ref8 ARGV , 1 , %rdi ; call atof ; movsd %xmm0 , Y(%rbp)
        ref8 ARGV , 2 , %rdi ; call atof ; movsd %xmm0 , M(%rbp)
        ref8 ARGV , 3 , %rdi ; call atof ; movsd %xmm0 , D(%rbp)

        literal_double 0e1.0 , %xmm0
        ucomisd M(%rbp) , %xmm0
        je  2f
        jmp 1f

1:
        literal_double 0e2.0 , %xmm0
        ucomisd M(%rbp) , %xmm0
        je  2f
        jmp 3f
        
2:
        movsd Y(%rbp) , %xmm0
        literal_double 0e1.0 , %xmm1
        subsd %xmm1 , %xmm0
        movsd %xmm0 , Y(%rbp)

        movsd M(%rbp) , %xmm0
        literal_double 0e12.0 , %xmm1
        addsd %xmm1 , %xmm0
        movsd %xmm0 , M(%rbp)
        
3:
        # ----------------------------------------------------------------------

        literal_double 0e0.0 , %xmm0

        movsd Y(%rbp) , %xmm1 ; literal_double 0e10000.0 , %xmm2 ; mulsd %xmm2 , %xmm1
        addsd %xmm1 , %xmm0

        movsd M(%rbp) , %xmm1 ; literal_double   0e100.0 , %xmm2 ; mulsd %xmm2 , %xmm1
        addsd %xmm1 , %xmm0

        movsd D(%rbp) , %xmm1
        addsd %xmm1 , %xmm0

        literal_double 0e15821015.0 %xmm1

        ucomisd %xmm1 , %xmm0

        jae 1f
        jmp 2f

1:
        movsd          Y(%rbp) , %xmm0
        literal_double 0e100.0 , %xmm1
        divsd %xmm1 , %xmm0
        call trunc
        movsd %xmm0 , A(%rbp)

        literal_double 0e2.0 , %xmm3

        movsd          A(%rbp) , %xmm1
        literal_double 0e-1.0  , %xmm2
        mulsd %xmm2 , %xmm1

        addsd %xmm1 , %xmm3

        movsd A(%rbp) , %xmm0
        literal_double 0e4.0 , %xmm2
        divsd %xmm2 , %xmm0
        call trunc
        addsd %xmm0 , %xmm3
        movsd %xmm3 , B(%rbp)

        jmp 10f

2:     
        literal_double 0e0.0 , %xmm0
        movsd %xmm0 , B(%rbp)
        
        jmp 10f

10:
        literal_double 0e0.0 , %xmm0
        ucomisd Y(%rbp) , %xmm0
        ja  1f
        jmp 2f

1:
        literal_double 0e365.25 , %xmm0
        movsd Y(%rbp) , %xmm1
        mulsd %xmm1 , %xmm0

        literal_double 0e0.75 , %xmm1
        subsd %xmm1 , %xmm0

        call trunc

        movsd %xmm0 , C(%rbp)

        jmp 10f

2:      
        literal_double 0e365.25 , %xmm0
        movsd Y(%rbp) , %xmm1
        mulsd %xmm1 , %xmm0

        call trunc

        movsd %xmm0 , C(%rbp)

        jmp 10f

10:
        movsd M(%rbp) , %xmm0
        literal_double 0e1.0 , %xmm1
        addsd %xmm1 , %xmm0
        literal_double 30.6001 , %xmm1
        mulsd %xmm1 , %xmm0
        call trunc
        movsd %xmm0 , E(%rbp)


        movsd B(%rbp) , %xmm0

        movsd C(%rbp) , %xmm1 ; addsd %xmm1 , %xmm0
        movsd E(%rbp) , %xmm1 ; addsd %xmm1 , %xmm0
        movsd D(%rbp) , %xmm1 ; addsd %xmm1 , %xmm0

        literal_double 0e1720994.5 %xmm1 ; addsd %xmm1 , %xmm0

        movsd %xmm0 , RES(%rbp)

        print_double RES(%rbp)
        print_nl

        mov $0 , %rax

        leave
        ret

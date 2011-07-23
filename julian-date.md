
# Calculate the Julian Day

# C

```c

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main ( int argc , char * argv[] )
{
    double y ;
    double m ;
    double d ;
    double a ;
    double b ;
    double c ;
    double e ;
    double res ;

    y = atof( argv[1] ) ;
    m = atof( argv[2] ) ;
    d = atof( argv[3] ) ;

    if ( m == 1.0 || m == 2.0 )
    {
        y = y -  1.0 ;
        m = m + 12.0 ;
    }

    if ( ( y*10000 + m*100 + d ) >= ( 1582*10000 + 10*100 + 15 ) )
    {
        a = trunc( y / 100.0 ) ;

        b = 2 - a + trunc( a / 4.0 ) ;
    } else {
        b = 0 ;
    }

    if ( y < 0 )
        c = trunc( 365.25 * y - 0.75 ) ;
    else
        c = trunc( 365.25 * y ) ;

    e = trunc( 30.6001 * (m+1) ) ;

    res = b + c + e + d + 1720994.5 ;

    printf( "%f\n" , res ) ;
    
    return 0 ;
}
```

# Assembly

```s

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
```

# Assemble and run

    $ gcc julian-date.s -lm && ./a.out 2011 7 23
    2455765.500000

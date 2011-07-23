
# Add two doubles

# C

```c

int main ( int argc , char * argv[] )
{
    double a ;
    double b ;
    double c ;

    a = atof( argv[1] ) ;
    b = atof( argv[2] ) ;

    c = a + b ;

    printf( "%f\n" , c ) ;
    
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
        stack_allocate A    , 8
        stack_allocate B    , 8
        stack_allocate C    , 8

        mov %rsi , ARGV(%rbp)

        ref8 ARGV , 1 , %rdi ; call atof ; movsd %xmm0 , A(%rbp)
        ref8 ARGV , 2 , %rdi ; call atof ; movsd %xmm0 , B(%rbp)

        movsd A(%rbp) , %xmm0
        movsd B(%rbp) , %xmm1
        
        addsd %xmm1 , %xmm0

        movsd %xmm0 , C(%rbp)

        print_double C(%rbp)

        print_nl

        mov $0 , %rax

        leave
        ret
```

# Assemble and run

    $ gcc add-two-doubles.s && ./a.out 1.2 3.4
    4.600000

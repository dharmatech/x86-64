
# Compare two ints

# C

```c

#include <stdio.h>
#include <stdlib.h>

int main ( int argc , char * argv[] )
{
    int a ;
    int b ;
    
    a = atoi( argv[1] ) ;
    b = atoi( argv[2] ) ;

    if ( a > b )
        printf( "greater than\n" ) ;
    else if ( a < b )
        printf ( "less than\n" ) ;
    else
        printf ( "equal\n" ) ;

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
```

# Assemble and run

    $ gcc compare-ints.s && ./a.out 1 2
    less than
    $ gcc compare-ints.s && ./a.out 2 1
    greater than
    $ gcc compare-ints.s && ./a.out 1 1
    equal

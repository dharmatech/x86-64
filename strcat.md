
# Call the strcat glibc C function

# C

```c

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main ( int argc , char * argv[] )
{
    char * data = malloc( 1000 ) ;

    data[0] = '\0' ;
    
    strcat( data , argv[1] ) ;
    strcat( data , argv[2] ) ;

    printf( "%s\n" , data ) ;
    
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
```

# Assemble and run

    $ gcc strcat.s -lm && ./a.out abc def
    abcdef

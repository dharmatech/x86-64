
# Print a literal double

# C

```c

#include <stdio.h>

int main ()
{
    printf ( "%f\n" , 1.2 ) ;
    
    return 0 ;
}
```

# Assembly

```s

        .include "utils.s"
        
        global_text main

        prepare_stack

        literal_double 0e1.2 %xmm0

        print_double %xmm0

        print_nl

        return_integer $0
```

# Assemble and run

    $ gcc print-literal-double.s -lm && ./a.out
    1.2



# Print a literal integer

# C

```c

#include <stdio.h>

int main ()
{
    printf ( "%i\n" , 123 ) ;
    
    return 0 ;
}
```

# Assembly

```s

        .include "utils.s"
        
        global_text main

        prepare_stack

        mov $123 , %rax

        print_int %rax

        print_nl

        return_integer $0
```




# Print a literal string

# C

```c

#include <stdio.h>

int main ()
{
    printf("%s", "abc") ;
    
    return 0 ;
}
```

# Assembly

```s

        .include "utils.s"

        global_text main

        prepare_stack

        literal_string "abc" , %rax

        print_string %rax

        print_nl

        return_integer $0
```



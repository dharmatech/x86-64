
# ----------------------------------------------------------------------

        .macro prepare_stack
        push %rbp
        mov %rsp , %rbp
        .endm
        
# ----------------------------------------------------------------------

        .macro print_int var

        .section .rodata

1:
        .string "%i"

        .text

        mov $1b , %rdi
        mov \var , %rsi
        mov $0 , %rax

        call printf

        .endm

# ----------------------------------------------------------------------

        .macro print_double var

        .section .rodata

1:
        .string "%f"

        .text

        mov $1b , %rdi
        movsd \var , %xmm0
        mov $1 , %rax

        call printf

        .endm

# ----------------------------------------------------------------------

        .macro print_literal_string str
        .section .rodata
1:
        .string "\str"

        .text
        mov $1b , %rdi
        mov $0 , %rax
        call printf
        .endm

# ----------------------------------------------------------------------

        .macro print_string var
        mov \var , %rdi
        mov $0 , %rax
        call printf
        .endm

# ----------------------------------------------------------------------

        .macro print_nl
        .section .rodata
1:
        .string "\n"
        .text
        mov $1b , %rdi
        mov $0 , %rax
        call printf
        .endm
        
# ----------------------------------------------------------------------
        
        .macro ref8 var , i , dst

        mov \var(%rbp) , %rax
        mov    \i*8(%rax) , %rax
        mov %rax , \dst

        .endm

# ----------------------------------------------------------------------
        
        .macro set1 src , var , i
        mov  \var(%rbp) ,    %rax
        movb \src       , \i(%rax)
        .endm

# ----------------------------------------------------------------------

        .macro stack_allocate var , size

        .set offset , offset - \size

        .set \var , offset

        sub $\size , %rsp

        .endm

# ----------------------------------------------------------------------

        .macro literal_double num , dst
        .section .rodata
        .align 8
1:
        .double \num
        .text
        movsd 1b , \dst
        .endm

# ----------------------------------------------------------------------

        .macro literal_string str , dst
        .section .rodata
1:
        .string "\str"
        .text
        mov $1b , \dst
        .endm
        
# ----------------------------------------------------------------------
        
        .macro global_text name
        .text
        .global \name
        \name:
        .endm

# ----------------------------------------------------------------------

        .macro return_integer val
        mov \val , %rax
        leave
        ret
        .endm

# ----------------------------------------------------------------------
        
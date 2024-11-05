.data
list: .byte 1, 2, 3
len: .quad 3

.bss
result: .space 3

.text
.global main
main:
    movq len, %rcx                      
    movq $list, %rsi                    

push_loop:
    movb (%rsi), %al                 # Cargar el byte actual de 'list' en al
    movsbq %al, %rax                 # Cargar el byte en rax
    pushq %rax                       # Apilar el valor

    inc %rsi                          # Mover al siguiente elemento en 'list'
    loop push_loop                   # Repetir hasta que rcx llegue a cero

movq $result, %rdi                   # Cargar la dirección de 'result' en rdi
movq len, %rcx                       # Cargar la longitud del arreglo en rcx para el pop_loop

pop_loop:
    popq %rax                         # Desapilar el valor en rax
    movb %al, (%rdi)                # Mover el byte desapilado a 'result'
    inc %rdi                         # Mover a la siguiente posición en 'result'
    loop pop_loop                    # Repetir hasta que rcx llegue a cero

ret

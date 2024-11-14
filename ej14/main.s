.data
    msg_no_args: .string "Ingrese al menos un argumento\n"
    msg: .string "Cantidad de argumentos ingresados: %d. La suma es: %d\n"
.text
.global main

no_args:
    leaq msg_no_args, %rdi
    xor %rax, %rax
    call printf
    jmp end

main:
    pushq %rbp    
    movq %rdi, %r12
    dec %r12
    jz no_args
    movq %rsi, %r15

    movq $1, %rbx
    xor %r14, %r14

sum_loop:
    movq (%r15, %rbx, 8), %rdi # argv[rbx]
    call atoi                  # Llamar a atoi para convertir el string a int (resultado en %eax)
    movslq %eax, %rax          # Convertir el valor a 64 bits
    
    inc %rbx                   # Mover al siguiente argumento
    imul %rax
    add %rax, %r14              # Sumar el valor al acumulador

    cmpq %r12, %rbx  # ( rbx - r12 ) >= 0
    jle sum_loop


    movq %r12, %rsi # 1er argumento: cantidad de argumentos
    movq %r14, %rdx # 2do argumento: suma
    leaq msg, %rdi 
    xor %rax, %rax
    call printf

end:
    popq %rbp
    xorl %eax, %eax                      

    ret                   # Retornar

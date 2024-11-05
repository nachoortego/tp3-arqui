.section .data
a: .long 0x7fffffff
b: .long 1
fmt: .string "0x%x\n"
msg1: .string "Ejecutando foo1...\n"
msg2: .string "Ejecutando foo2...\n"

.section .text
.global main
.global foo1
.global foo2
.extern printf

main:
    call foo1
    # Guardar el resultado de foo1 en rdi
    movl %eax, %edi     
    # Llamar a foo2
    call foo2
    # Guardar el resultado de foo2 en rsi
    movl %eax, %esi    
    # Preparar argumentos para printf
    movq $fmt, %rdi     # Formato de printf (puntero a cadena, 64 bits)
    # Llamar a printf
    call printf

    # Salir
    xor %eax, %eax
    ret

foo1:
    # Imprimir "Ejecutando foo1..."
    movq $msg1, %rdi    # Cargar puntero a msg1 (64 bits)
    call printf

    # a = a + (b << 31)
    movl a, %eax         # Cargar a en eax (32 bits)
    movl b, %ebx         # Cargar b en ebx (32 bits)
    shl $31, %ebx       # b << 31
    add %ebx, %eax      # a = a + (b << 31)
    movl %eax, a        # Almacenar el nuevo valor de a (32 bits)

    # Imprimir el valor de a
    movq $fmt, %rdi     # Formato de printf (64 bits)
    movl %eax, %esi     # Argumento a printf (32 bits)
    call printf

    ret

foo2:
    # Imprimir "Ejecutando foo2..."
    movq $msg2, %rdi    # Cargar puntero a msg2 (64 bits)
    call printf

    # a = a + b
    movl a, %eax         # Cargar a en eax (32 bits)
    movl b, %ebx         # Cargar b en ebx (32 bits)
    add %ebx, %eax      # a = a + b
    movl %eax, a        # Almacenar el nuevo valor de a (32 bits)

    # Imprimir el valor de a
    movq $fmt, %rdi     # Formato de printf (64 bits)
    movl %eax, %esi     # Argumento a printf (32 bits)
    call printf

    ret

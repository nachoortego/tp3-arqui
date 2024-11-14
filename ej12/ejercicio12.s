.section .data
list: .long 10, 20, 30, 40, 50, 60, 70, 80, 90, 100  # Lista a sumar
length: .long 10                                     # Tamaño de la lista
format_max: .asciz "Maximo: %ld\n"
format_min: .asciz "Minimo: %ld\n"
format_promedio: .asciz "Promedio: %ld\n"
format_suma: .asciz "Suma: %ld\n"

.section .bss
result_sum: .long 0
result_max: .long 0
result_min: .long 0
result_avg: .long 0

.section .text
.globl main

main:
    xor %eax, %eax         # %eax lo inicializamos en 0, para hacer la suma
    movl length, %ecx      # Cargamos el largo de la lista
    lea list, %rdi         # Cargamos la dirección de la lista en %rdi
    
    # inicializamos las variables de maximo y minimo usando el primer elemento de la lista
    movl (%rdi), %edx
    movl %edx, result_max
    movl %edx, result_min

    # llamo a la funcion encargada de hacer la suma, encontrar minimo y max
    call suma_max_min_loop
    

    # calculo el promedio ya teniendo el maximo de la suma
    movl result_sum, %eax
    movl length, %ecx
    cltd                   # extiende el signo de %eax a 64bits para poder hacer la division, por lo que entendi siempre usa %eax
    idivl %ecx             # divide %edx:%eax por %ecx, el resultado de la division entera queda en %eax y el resto en %edx
    movl %eax, result_avg

    call print_results

    ret

suma_max_min_loop:
    
    addl (%rdi), %eax # En %eax vamos a estar sumando los valores de la lista

    # comparamos y actualizamos el maximo
    movl (%rdi), %edx
    movl result_max, %ebx
    cmpl %ebx, %edx         # Compara el numero actual con el maximo, en caso de que sea mayor, prende la flag correspondiente 
    cmovg %edx, %ebx        # Este operador hace solo el movimiento de guardar el nuevo mayor numero cuando la operacion anterior de comparacion prendio la flag correspondiente
    movl %ebx, result_max

    # Comparar y actualizar el mínimo
    movl result_min, %ebx       
    cmpl %ebx, %edx             
    cmovl %edx, %ebx            
    movl %ebx, result_min       

    addq $4, %rdi           # se mueve al siguiente elemento (4 bytes por int)
    loop suma_max_min_loop  # decrementa el largo de la fila y repite si es distinto a 0

    movl %eax, result_sum
    ret

print_results:
    movl result_max, %esi
    movl $format_max, %edi
    xor %eax, %eax
    call printf

    movl result_min, %esi
    movl $format_min, %edi
    xor %eax, %eax
    call printf

    movl result_avg, %esi
    movl $format_promedio, %edi
    xor %eax, %eax
    call printf

    movl result_sum, %esi
    movl $format_suma, %edi
    xor %eax, %eax
    call printf

    ret

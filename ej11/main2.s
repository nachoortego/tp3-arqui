.data
list: .byte 1, 2
longi: .byte 2
pos: .quad 0
.text
.global main
main:
    movq longi, %rcx
    movq pos, %r11
inicio:
    movq $0, %rax # inicio rax con 0
    movb list(%r11), %al # Como funciona esto? Porque es list[%r11] ? pq es la direccion de var + rax (el valor dentro de rax?)
    movq $0, %r10 # inicio el reg aux r10 como 0
    movb %al, %r10b # muevo al primer byte del registro auxiliar r10 el primer byte de rax
    pushq %r10 # pusheo a la pila el registro aux r10 (contiene el primer elemento de la lista)
    incq %r11 
    loop inicio
# Ya se lleno la pila y la primer posicion tiene el ultimo valor, ahora vamos a guardarlos
    movq longi, %rcx # Inicio el loop de nuevo
    movq $0, %rax # de nuevo rax con 0
    movq pos, %r11 # de nuevo r11 en 0 (indica posicion)

vaciar:
    popq %rax # Guardo en rax el tope de la pila (el ultimo elemento de la lista)
    movb %al, list(%r11) # Piso la lista en la posicion inicial con el ultimo elemento de la lista (el tope de la pila)
    incq %r11 # Aumento el indice
    loop vaciar # Repito con el penultimo en la segunda posicion...

    ret # Al finalizar retorno
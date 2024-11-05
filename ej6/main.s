.data                    # Sección de datos (aunque no hay datos en este caso)
.text                    # Sección de código

.global main             # Declara la etiqueta 'main' como global, para que el linker pueda encontrarla
main:                    # Inicio de la función 'main'

# ----------1)a)
movq $1, %rax          # Mueve el valor 1 al registro %rax
sal $31, %rax          # Desplaza a la izquierda el valor en %rax por 31 bits

# ----------1)b)

movq $1, %rax            # Mueve el valor 1 al registro %rax
sal $31, %rax            # Desplaza a la izquierda el valor en %rax por 31 bits, colocando 1 en el bit más significativo
movq $1, %rbx            # Mueve el valor 1 al registro %rbx
sal $15, %rbx            # Desplaza a la izquierda el valor en %rbx por 15 bits
or %rbx, %rax            # Realiza un OR entre %rax y %rbx, almacenando el resultado en %rax
movq %rax, %rdi          # Mueve el valor en %rax al registro %rdi (posiblemente para el código de salida)

# ----------1)c)

movq $-1, %rax           # Mueve el valor -1 (todos los bits en 1) al registro %rax
andq $0xFFFFFF00, %rax   # Realiza una operación AND entre %rax y 0xFFFFFF00, borrando los últimos 8 bits

# ----------1)d)

movq $0xAA, %rax         # Mueve el valor 0xAA al registro %rax
sal $24, %rax            # Desplaza a la izquierda el valor en %rax por 24 bits
or $0xAA, %rax           # Realiza una operación OR entre %rax y 0xAA

# ----------1)e)

movq $5, %rax            # Mueve el valor 5 al registro %rax
sal $8, %rax             # Desplaza a la izquierda el valor en %rax por 8 bits

# ----------1)f)

movq $1, %rax            # Mueve el valor 1 al registro %rax
sal $8, %rax             # Desplaza a la izquierda el valor en %rax por 8 bits, obteniendo 0x100
not %rax                 # Invierte todos los bits en %rax
and $-1, %rax            # Realiza una operación AND entre %rax y -1 (no afecta el valor, ya que -1 es todos los bits en 1)

# ----------1)g)

movq $0, %rax            # Mueve el valor 0 al registro %rax
subq $1, %rax            # Resta 1 a %rax, resultando en -1

# ----------1)h)

movq $0x80000000, %rax   # Mueve el valor 0x80000000 al registro %rax
adcq $0x80000000, %rax   # Suma 0x80000000 al valor en %rax, considerando el acarreo de la última operación

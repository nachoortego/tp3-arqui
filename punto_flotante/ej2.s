.data
a: .float 1.0, 2.0, 3.0, 4.0, 5.0
b: .float 1.5, 3.2 , 4.5, 5.0, 6.0
len: .byte 5
format: .asciz "Resultado: %f %f %f %f %f\n"

.text
.global main
.global sum_simd

sum_simd:
  pushq %rbp
  movq %rsp, %rbp

  # Argumentos
  movq %rdi, %r8  # a
  movq %rsi, %r9  # b
  movl %edx, %ecx # len

  xorl %eax, %eax

simd_loop:
  # Comparar índice con len - 4
  cmp %ecx, %eax
  jl scalar_loop         # Si i >= len, salir del bucle

  # Cargar 4 elementos de a en xmm0
  movaps (%r8,%rax,4), %xmm0
  # Cargar 4 elementos de b en xmm1
  movaps (%r9,%rax,4), %xmm1
  # Sumar xmm1 a xmm0
  addps %xmm1, %xmm0
  # Guardar el resultado en a[i]
  movaps %xmm0, (%r8,%rax,4)
  # Incrementar índice en 4
  add $4, %eax
  
  jmp simd_loop

scalar_loop:
  # Comparar índice con len
  cmp %ecx, %eax
  jge end_simd         # Si i >= len, salir del bucle

  # Cargar a[i] en xmm0
  movss (%r8,%rax,4), %xmm0
  # Cargar b[i] en xmm1
  movss (%r9,%rax,4), %xmm1
  # Sumar xmm1 a xmm0
  addss %xmm1, %xmm0
  # Guardar el resultado en a[i]
  movss %xmm0, (%r8,%rax,4)

  # Incrementar índice
  incl %eax
  jmp scalar_loop

end_simd:
  movq %rbp, %rsp
  popq %rbp
  ret

main:
  pushq %rbp
  movq %rsp, %rbp

  # Argumentos
  leaq a(%rip), %rdi  # a
  leaq b(%rip), %rsi  # b
  movzbl len(%rip), %edx # len

  call sum_simd

  # Imprimir el resultado
  leaq format(%rip), %rdi
  movl $1, %eax  # Número de argumentos de punto flotante

  # Convertir float a double y mover a los registros correctos
  cvtss2sd (%rdi), %xmm0
  cvtss2sd 4(%rdi), %xmm1
  cvtss2sd 8(%rdi), %xmm2
  cvtss2sd 12(%rdi), %xmm3
  cvtss2sd 16(%rdi), %xmm4

  call printf

  # Epilogue
  movq %rbp, %rsp
  popq %rbp
  ret

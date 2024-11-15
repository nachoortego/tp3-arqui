.data
a: .float 1.0, 2.0, 3.0, 4.0, 5.0
b: .float 1.5, 3.2 , 4.5, 5.0, 6.0
len: .byte 5
format: .asciz "Resultado: %d %d %d %d %d\n"

.text
.global main

main:
  pushq %rbp
  movq %rsp, %rbp

  # Argumentos
  leaq a, %r8  # a
  leaq b, %r9  # b
  movsbq len, %rcx # len

  xorq %rax, %rax

suma:
  # Cargar a[i] en xmm0
  movss (%r8,%rax,4), %xmm0

  # Cargar b[i] en xmm1
  movss (%r9,%rax,4), %xmm1

  # Sumar xmm1 a xmm0
  addss %xmm1, %xmm0

  # Guardar el resultado en a[i]
  movss %xmm0, (%r8,%rax,4)

  incq %rax
  loop suma

end:
  # Imprimir el resultado
  leaq format, %rdi
  movq $5, %rax
  movss (%r8), %xmm0
  movss 4(%r8), %xmm1
  movss 8(%r8), %xmm2
  movss 12(%r8), %xmm3
  movss 16(%r8), %xmm4

  call printf

  # Epilogue
  movq %rbp, %rsp
  popq %rbp
  ret
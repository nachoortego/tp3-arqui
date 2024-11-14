.section .text
.global fact1

fact1:
  # preservar la pila
  pushq %rbp
  movq %rsp, %rbp

  # caso base 
  cmpq $1, %rdi
  jle base

  pushq %rdi  # guardar x en la pila
  decq %rdi
  call fact1  # recursion

  # calcular factorial
  popq %rdi
  imulq %rdi, %rax

  jmp termino

base:
  movq %rdi, %rax

termino:

  movq %rbp, %rsp
  popq %rbp
ret

.section .text
.global fact2
fact2:
  movl $1, %eax       # se inicializa el factorial en 1
  movq %rdi, %rcx     # se carga en rcx el numero del cual sacaremos el factorial

cuenta:
  mulq %rcx
  loop cuenta         # se calcula el factorial usando rcx y rax
ret

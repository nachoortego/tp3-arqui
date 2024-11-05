.global main
main:
  movl $-1, %eax
  movl $2, %ecx
  imull %ecx

  # Desplazar %rdx a la izquierda 32 bits
  salq $32, %rdx
  # Combinar %rdx y %rax usando OR bit a bit, resultado almacenado en %rax
  orq %rdx, %rax

  xorq %rax, %rax
  xorq %rdx, %rdx

  movw $-1, %ax
  movw $2, %cx
  mulw %cx

  # Desplazar %edx a la izquierda 16 bits
  sall $16, %edx
  # Combinar %edx y %eax usando OR bit a bit, resultado almacenado en %eax
  orl %edx, %eax

  ret

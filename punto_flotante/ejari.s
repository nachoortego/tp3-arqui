.global sum_simd
sum_simd:
  xorl %ecx, %ecx
simd_loop:
  movl %ecx, %eax
  addl $4, %eax
  cmp %edx, %eax
  jg scalar_loop
  
  movaps (%rsi, %rcx, 4), %xmm0
  addps (%rdi, %rcx, 4), %xmm0
  movaps %xmm0, (%rdi, %rcx, 4)

  addl $4, %ecx
  jmp simd_loop

scalar_loop:
  cmp %edx, %ecx
  jge fin_scalar_loop

  movss (%rdi, %rcx, 4), %xmm0
  addss (%rsi, %rcx, 4), %xmm0
  movss %xmm0, (%rdi, %rcx, 4)

  incl %ecx
  jmp scalar_loop
fin_scalar_loop:
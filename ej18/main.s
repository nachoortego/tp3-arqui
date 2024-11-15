.data
  a: .byte 1
  b: .byte 2
  c: .byte 3
  d: .long 4
  e: .byte 5
  f: .float 1.0
  g: .double 2.0
  h: .long 6
  i: .long 7
  j: .long 8

.text
.global main

leave:
  movq %rbp, %rsp           
  popq %rbp    
  ret          

calculo:
  pushq %rbp                # Guardar el marco de pila anterior
  movq %rsp, %rbp
  
  xor %rax, %rax
  
  movsbl %dil, %edi         # Convertir a (char a) a int en %edi
  movsbl %dl, %edx          # Convertir c (char c) a int en %edx
  
  # (int) (a + c + d) -> %eax
  add %edi, %eax            # Sumar a (%edi) a %eax
  add %edx, %eax            # Sumar c (%edx) a %eax
  add %ecx, %eax            # Sumar d (%ecx) a %eax

  # Capturar los 2 parámetros pasados por la pila y sumarlos
  movl 16(%rbp), %esi       # Segundo parámetro (j)
  movl 24(%rbp), %edi       # Primer parámetro (i)
  add %esi, %edi            # Sumar los parámetros
  imul %edi, %eax            # Agregar el resultado a %eax
  
  call leave             
  ret                       

main:
  pushq %rbp                # Guardar el marco de pila anterior
  movq %rsp, %rbp

  # Cargar valores en los registros
  movb a, %dil              # char a
  movb b, %sil              # char b
  movb c, %dl               # char c
  movl d, %ecx              # int d
  movb e, %r8b              # char e
  
  movss f, %xmm0   # float f
  movsd g, %xmm1   # double g

  movl h, %r9d              # int h

  movl i, %r12d              # int i
  movl j, %r13d              # int j
  
  movslq %r12d, %r12        # Convertir i a 64 bits
  movslq %r13d, %r13        # Convertir j a 64 bits

  # Pasar parámetros adicionales en la pila
  pushq %r12                # Push de i
  pushq %r13                # Push de j

  # Llamar a la función calculo
  call calculo

  # Restaurar el marco de pila anterior
  call leave

  ret                       # Retornar



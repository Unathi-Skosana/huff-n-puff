; asmsyntax=nasm

global heap_initialize
global heap_insert
global heap_remove

%define H [ebp + 8]
%define MAX_n [ebp - 4]
%define i [ebp - 8]

heap_initialize:
  push ebp
  mov ebp, esp
  sub esp, 8

  mov dword MAX_n, dword 256
  mov eax, H
  mov [eax], dword 0
  mov  dword i, dword 0

  add  eax, dword 4

  .for:
   mov  [eax], dword 0
   mov  [eax + 4], dword 0
   mov  [eax + 8], dword 0
   mov  [eax + 12], dword 0
   add  eax, dword 16
   mov  edx, dword i
   inc  edx
   mov dword i, edx
   cmp  edx, MAX_n
   jne  .for

   mov  esp, ebp
   pop  ebp
   ret


%define H    [ebp + 8]
%define node [ebp + 12]
%define c    [ebp - 4]
%define p    [ebp - 8]
%define temp [ebp - 24]

heap_insert:
  push ebp
  mov ebp, esp
  sub esp, 24

  mov ebx, H
  mov edx, [ebx]
  mov dword c, edx
  dec edx
  sar edx, 1
  mov dword p, edx

  add ebx, 4

  mov eax, dword c
  imul eax, dword 16
  mov edi, ebx
  add edi, eax

  mov esi, node

  mov ecx, 4
  rep movsd

  .while:
  mov eax, dword p
  cmp  eax, dword 0
  jl .done

  mov eax, dword p
  imul eax, dword 16
  mov edi, ebx
  add edi, eax

  mov esi, [edi]

  mov eax, dword c
  imul eax, dword 16
  mov edi, ebx
  add edi, eax
  mov eax, [edi]

  cmp eax, esi

  jge .else

  mov eax, dword p
  imul eax, dword 16
  mov esi, ebx
  add esi, eax
  mov edi, temp

  mov ecx, 4
  rep movsd

  mov eax, dword c
  imul eax, dword 16
  mov esi, ebx
  add esi, eax

  mov eax, dword p
  imul eax, dword 16
  mov edi, ebx
  add edi, eax

  mov ecx, 4
  rep movsd

  mov eax, dword c
  imul eax, dword 16
  mov edi, ebx
  add edi, eax
  mov esi, temp

  mov ecx, dword 4
  rep movsd

  mov eax, dword p
  mov dword c, eax
  dec eax
  sar eax, 1
  mov dword p, eax
  jmp .while

  .else:
  mov dword p, dword -1
  jmp .while

  .done:
  sub ebx, dword 4
  mov eax, [ebx]
  inc eax
  mov [ebx], eax
  mov  esp, ebp
  pop  ebp
  ret

  %define  H     [ebp + 8]
  %define  node  [ebp + 12]
  %define  n     [ebp - 4]
  %define  p     [ebp - 8]
  %define  c     [ebp - 12]
  %define  temp  [ebp - 28]

  heap_remove:
    push  ebp
    mov  ebp, esp
    push  ebx

    mov  eax, H
    mov  eax, [eax]
    mov  n, eax

    cmp  eax, dword 0
    jl  .done

    mov  ebx, node
    mov  eax, H
    add  eax, 4
    mov  esi, eax
    mov  edi, ebx
    mov  ecx, 4
    rep  movsd

    mov  ecx, n
    dec  ecx
    mov  edx, ecx
    imul  ecx, 16
    mov  edi, eax
    add  eax, ecx
    mov  esi, eax
    mov  ecx, 4
    rep  movsd

    mov  eax, n
    dec  eax
    mov  n, eax
    mov  ebx, H
    mov  [ebx], eax
    mov  p, dword 0
    mov  c, dword 1

  .while:
    mov  ebx, c
    mov  edx, n
    dec  edx
    cmp  ebx, edx
    jg  .done

    mov  ecx, dword H
    add  ecx, 4
    mov  eax, ecx
    mov  ebx, dword c
    mov  edx, ebx
    inc  ebx
    imul  ebx, 16
    imul  edx, 16
    add  ecx, ebx
    add  eax, edx
    mov  eax, [eax]
    mov  ecx, [ecx]
    cmp  eax, ecx
    jl  .if2
    mov  eax, dword c
    inc  eax
    mov  c, eax

  .if2:
    mov  ecx, dword H
    add  ecx, 4
    mov  ebx, dword p
    imul  ebx, 16
    mov  edx, ecx
    add  ecx, ebx
    mov  ebx, dword c
    imul  ebx, 16
    add  edx, ebx
    mov  eax, [ecx]
    mov  ebx, [edx]
    cmp  ebx, eax
    jg  .else

    mov  eax, ecx

    mov  esi, eax
    lea  edi, temp
    mov  ecx, 4
    rep  movsd

    mov  esi, edx
    mov  edi, eax
    mov  ecx, 4
    rep  movsd

    lea  esi, temp
    mov  edi, edx
    mov  ecx, 4
    rep  movsd

    mov  eax, dword c
    mov  p, eax
    mov  edx, dword p
    sal  edx, 1
    inc  edx
    mov  c, edx

    jmp  .while

  .else:
    mov  eax, n
    mov  c, eax

    jmp  .while

  .done:
    pop  ebx
    mov  esp, ebp
    pop  ebp
    ret

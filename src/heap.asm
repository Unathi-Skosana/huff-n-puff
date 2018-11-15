; asmsyntax=nasm

global heap_initialize
global heap_insert
global heap_remove

%define H [ebp + 8]
%define	MAX_HEAP_SIZE [ebp - 4]
%define	i [ebp - 8]

heap_initialize:
  push ebp
  mov ebp, esp
  sub esp, 8

  mov dword MAX_HEAP_SIZE, dword 256
  mov eax, H
  mov [eax], dword 0
  mov	dword i, dword 0

  add	eax, dword 4
  .for:
    mov	[eax], dword 0
    mov	[eax + 4], dword 0
    mov	[eax + 8], dword 0
    mov	[eax + 12], dword 0
    add	eax, dword 16
    mov	edx, dword i
    inc	dword i
    cmp	edx, MAX_HEAP_SIZE
    jne	.for

    mov	esp, ebp
    pop	ebp
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
  cmp	eax, dword 0
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
  mov	esp, ebp
  pop	ebp
  ret

%define H    [ebp + 8]
%define node [ebp + 12]
%define c    [ebp - 4]
%define p    [ebp - 8]
%define temp [ebp - 24]

heap_remove:
   push ebp
   mov ebp, esp
   sub esp, 24

   mov ebx, H
   mov eax, [ebx]
   cmp eax, dword 0

   jl .done

   mov esi, ebx
   add esi, dword 4
   mov edi, node

   mov ecx, dword 4
   rep movsd

   mov edi, ebx
   add edi, dword 4

   mov eax, [ebx]
   dec eax
   imul eax, dword 16
   mov esi, edi
   add esi, eax

   mov ecx, dword 4
   rep movsd

   mov eax, [ebx]
   dec eax
   mov [ebx], eax

   mov dword p, dword 0
   mov dword c, dword 1

   .while:
    mov esi, [ebx]
    dec esi
    mov eax, dword c
    cmp eax, esi

    jg .done

    mov edi, ebx
    add edi, dword 4
    mov eax, dword c
    inc eax
    imul eax, dword 16
    add edi, eax
    mov ecx, [edi]

    mov edi, ebx
    add edi, dword 4
    mov eax, dword c
    imul eax, dword 16
    add edi, eax
    mov eax, [edi]

    cmp eax, ecx
    jl .after_inc

    mov eax, dword c
    inc eax
    mov dword c, eax

   .after_inc:
    mov edi, ebx
    add edi, dword 4
    mov eax, dword p
    imul eax, dword 16
    add edi, eax
    mov ecx, [edi]

    mov edi, ebx
    add edi, dword 4
    mov eax, dword c
    imul eax, dword 16
    add edi, eax
    mov eax, [edi]

    cmp eax, ecx
    jg .else

    mov esi, ebx
    add esi, dword 4
    mov eax, dword p
    imul eax, dword 16
    add esi, eax
    mov edi, temp

    mov ecx, dword 4
    rep movsd

    mov esi, ebx
    add esi, dword 4
    mov eax, dword c
    imul eax, dword 16
    add esi, eax

    mov edi, ebx
    add edi, dword 4
    mov eax, dword p
    imul eax, dword 16
    add edi, eax

    mov ecx, dword 4
    rep movsd

    mov edi, ebx
    add edi, dword 4
    mov eax, dword c
    imul eax, dword 16
    add edi, eax
    mov esi, temp

    mov ecx, dword 4
    rep movsd

    mov eax, dword c
    mov dword p, eax
    sal eax, 1
    inc eax
    mov dword c, eax

    jmp .while

    .else:
    mov eax, [ebx]
    mov dword c, eax

    jmp .while

   .done:
    mov	esp, ebp
    pop	ebp
    ret

; asmsyntax=nasm
extern malloc
extern heap_insert
extern heap_remove
extern c_heap_insert
extern c_heap_remove

global huffman_build_tree
global huffman_initialize_table
global huffman_build_table


%define h  [ebp + 8]
%define t  [ebp + 12]
%define x  [ebp - 4]
%define y  [ebp - 8]
%define z  [ebp - 12]

huffman_build_tree:
    push  ebp
    mov   ebp, esp
    sub esp, 12

    mov dword x, 0x0
    mov dword y, 0x00
    mov dword z, 0x00


    .while:
    mov esi, h
    mov eax, [esi]

    cmp eax, 0
    je .done

    mov esi, h
    mov eax, [esi]

    cmp eax, 1
    jne .else

    mov edx, t
    mov eax, [edx]
    push eax

    mov ecx, h
    push ecx

    call heap_remove
    add esp, 8

    jmp .done

    .else:
    push dword 16
    call malloc
    add esp, 4

    mov x, eax

    push dword 16
    call malloc

    add esp, 4

    mov y, eax

    push dword 16
    call malloc
    add esp, 4

    mov z, eax

    mov ecx, x
    push ecx

    mov edx, h
    push edx

    call heap_remove
    add esp, 8

    mov ecx, y
    push ecx

    mov edx, h
    push edx

    call heap_remove
    add esp, 8

    mov ecx, x
    mov edi, y
    mov esi, z

    mov [esi + 8], ecx
    mov [esi + 12], edi
    mov eax, [ecx]
    add eax, [edi]
    mov [esi], eax


    push esi
    mov edi, h
    push edi

    call heap_insert
    add esp, 8

    jmp .while

    .done:
    mov esp, ebp
    pop ebp
    ret


%define r  [ebp + 8]
%define t  [ebp + 12]
%define code  [ebp + 16]
%define size  [ebp + 20]

huffman_build_table:
    push  ebp
    mov   ebp, esp

    mov esi, r
    add esi, 8
    cmp dword [esi], 0x00

    je .if_1

    mov eax, size
    inc eax
    push eax

    mov eax, code
    imul eax, 2
    push eax

    mov edi, t
    push edi

    mov esi, r
    add esi, 8
    push dword [esi]

    call huffman_build_table
    add esp, 16


    .if_1:
    mov esi, r
    add esi, 12
    cmp dword [esi], 0

    je .if_2

    mov eax, size
    inc eax
    push eax

    mov eax, code
    imul eax, 2
    inc eax
    push eax

    mov edi, t
    push edi

    mov esi, r
    add esi, 12
    push dword [esi]

    call huffman_build_table
    add esp, 16

    .if_2:
    mov edi, r
    add edi, 8
    cmp dword [edi], 0x00
    jne .done

    mov edi, r
    add edi, 12

    cmp dword [edi], 0x00
    jne .done

    mov edi, r
    add edi, 4
    mov eax, dword [edi]
    imul eax, 8
    mov esi, t
    add esi, eax

    mov ecx, code
    mov dword [esi], ecx

    mov edi, r
    add edi, 4
    mov eax, dword [edi]
    imul eax, 8

    mov esi, t
    add esi, eax
    add esi, 4
    mov edx, size
    mov dword [esi], edx

    .done:
    mov esp, ebp
    pop ebp
    ret


%define t  [ebp + 8]
%define MAX_HEAP_SIZE [ebp - 4]
%define i  [ebp - 8]

huffman_initialize_table:
    push ebp
    mov ebp, esp
    sub esp, 8

    mov dword MAX_HEAP_SIZE, dword 256
    mov esi, t
    mov  dword i, dword 0

    .for:
    mov  [esi], dword 0
    mov  [esi + 4], dword 0
    add  esi, dword 8
    mov  eax, dword i
    inc eax
    mov dword i, eax
    cmp  eax, MAX_HEAP_SIZE
    jne  .for

    mov  esp, ebp
    pop  ebp
    ret

    .file "test.c"
    .intel_syntax noprefix
    .text
    .balign 16
    .globl  func2
    .type func2, @function
func2:
    .cfi_startproc
    sub rsp, 40
    mov QWORD PTR [rsp], rdi
    mov DWORD PTR [rsp+8], esi
    mov DWORD PTR [rsp+12], edx
    mov eax, DWORD PTR [rsp+12]
    cdqe
    lea rdx, [rax*4]
    mov rax, QWORD PTR [rsp]
    add rax, rdx
    mov eax, DWORD PTR [rax]
    mov DWORD PTR [rsp+16], eax
    mov eax, DWORD PTR [rsp+8]
    dec eax
    mov DWORD PTR [rsp+32], eax
    mov eax, DWORD PTR [rsp+8]
    mov DWORD PTR [rsp+36], eax
    jmp .L3
    .balign 16
.L5:
    mov eax, DWORD PTR [rsp+36]
    cdqe
    lea rdx, [rax*4]
    mov rax, QWORD PTR [rsp]
    add rax, rdx
    mov eax, DWORD PTR [rax]
    cmp DWORD PTR [rsp+16], eax
    jl  .L4
    add DWORD PTR [rsp+32], 1
    mov eax, DWORD PTR [rsp+36]
    cdqe
    lea rdx, [rax*4]
    mov rax, QWORD PTR [rsp]
    add rdx, rax
    mov eax, DWORD PTR [rsp+32]
    cdqe
    lea rcx, [rax*4]
    mov rax, QWORD PTR [rsp]
    add rax, rcx
    mov rsi, rdx
    mov rdi, rax
    mov eax, DWORD PTR [rdi]
    mov r10d, eax
    mov eax, DWORD PTR [rsi]
    mov DWORD PTR [rdi], eax
    mov DWORD PTR [rsi], r10d
    .balign 16
.L4:
    add DWORD PTR [rsp+36], 1
    .balign 16
.L3:
    mov eax, DWORD PTR [rsp+36]
    cmp eax, DWORD PTR [rsp+12]
    jl  .L5
    mov eax, DWORD PTR [rsp+12]
    cdqe
    lea rdx, [rax*4]
    mov rax, QWORD PTR [rsp]
    add rdx, rax
    mov eax, DWORD PTR [rsp+32]
    cdqe
    inc rax
    lea rcx, [rax*4]
    mov rax, QWORD PTR [rsp]
    add rax, rcx
    mov rsi, rdx
    mov rdi, rax
    mov eax, DWORD PTR [rdi]
    mov r10d, eax
    mov eax, DWORD PTR [rsi]
    mov DWORD PTR [rdi], eax
    mov DWORD PTR [rsi], r10d
    mov eax, DWORD PTR [rsp+32]
    inc eax
    add rsp, 40
    ret
    .cfi_endproc
    .balign 16
    .globl  func3
    .type func3, @function
func3:
    .cfi_startproc
    sub rsp, 40
    mov QWORD PTR [rsp], rdi
    mov DWORD PTR [rsp+8], esi
    mov DWORD PTR [rsp+12], edx
    mov eax, DWORD PTR [rsp+8]
    cmp eax, DWORD PTR [rsp+12]
    jge .L9
    mov edx, DWORD PTR [rsp+12]
    mov ecx, DWORD PTR [rsp+8]
    mov rax, QWORD PTR [rsp]
    mov esi, ecx
    mov rdi, rax
    call  func2
    mov DWORD PTR [rsp+32], eax
    mov eax, DWORD PTR [rsp+32]
    lea edx, [rax-1]
    mov ecx, DWORD PTR [rsp+8]
    mov rax, QWORD PTR [rsp]
    mov esi, ecx
    mov rdi, rax
    call  func3
    mov eax, DWORD PTR [rsp+32]
    lea ecx, [rax+1]
    mov edx, DWORD PTR [rsp+12]
    mov rax, QWORD PTR [rsp]
    mov esi, ecx
    mov rdi, rax
    call  func3
    .balign 16
.L9:
    nop
    add rsp, 40
    ret
    .cfi_endproc
.LFE2:
    .size func3, .-func3
    .ident  "GCC: (GNU) 11.3.0"
    .section  .note.GNU-stack,"",@progbits

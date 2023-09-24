    .file	"test.c"
	.intel_syntax noprefix
	.text

	.p2align 4
	.globl	func1
	.type	func1, @function
func1:
	.cfi_startproc
	mov	eax, DWORD PTR [rdi]
	mov	edx, DWORD PTR [rsi]
	mov	DWORD PTR [rdi], edx
	mov	DWORD PTR [rsi], eax
	ret
	.cfi_endproc
	
	.p2align 4
	.globl	func2
	.type	func2, @function
func2:
	.cfi_startproc
	.p2align 4,,10
	movsx	rax, edx
	lea	r11, [rdi+rax*4]
	mov	r8d, DWORD PTR [r11]
	lea	eax, [rsi-1]
	cmp	edx, esi
	.p2align 4,,10
	jle	.L3
	movsx	r9, esi
	lea	rcx, [rdi+r9*4]
	sub	edx, esi
	lea	edx, [rdx-1]
	add	rdx, r9
	lea	rsi, [rdi+4+rdx*4]
	.p2align 4,,10
	jmp	.L5
	.p2align 4,,10
.L4:
	add	rcx, 4
	cmp	rcx, rsi
	.p2align 4,,10
	je	.L3
	.p2align 4,,10
.L5:
	mov	edx, DWORD PTR [rcx]
	cmp	edx, r8d
	.p2align 4,,10
	jg	.L4
	add	eax, 1
	movsx	r9, eax
	lea	r9, [rdi+r9*4]
	mov	r10d, DWORD PTR [r9]
	mov	DWORD PTR [r9], edx
	mov	DWORD PTR [rcx], r10d
	.p2align 4,,10
	jmp	.L4
	.p2align 4,,10
.L3:
	movsx	rdx, eax
	lea	rdx, [rdi+4+rdx*4]
	mov	ecx, DWORD PTR [rdx]
	mov	esi, DWORD PTR [r11]
	mov	DWORD PTR [rdx], esi
	mov	DWORD PTR [r11], ecx
	add	eax, 1
	ret
	.cfi_endproc

	.p2align 4
	.globl	func3
	.type	func3, @function
func3:
	.cfi_startproc
	.p2align 4,,10
	cmp	esi, edx
	.p2align 4,,10
	jl	.L13
	ret
	.p2align 4,,10
.L13:
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	mov	r12, rdi
	mov	r13d, esi
	mov	ebx, edx
	call	func2
	mov	ebp, eax
	lea	edx, [rax-1]
	mov	esi, r13d
	mov	rdi, r12
	call	func3
	lea	esi, [rbp+1]
	mov	edx, ebx
	mov	rdi, r12
	call	func3
	add	rsp, 8
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc

	.ident	"GCC: (GNU) 11.3.0"
	.section	.note.GNU-stack,"",@progbits


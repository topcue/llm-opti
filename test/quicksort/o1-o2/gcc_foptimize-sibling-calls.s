	.file	"quicksort.c"
	.intel_syntax noprefix
	.text
	.globl	func1
	.type	func1, @function
func1:
.LFB11:
	.cfi_startproc
	mov	eax, DWORD PTR [rdi]
	mov	edx, DWORD PTR [rsi]
	mov	DWORD PTR [rdi], edx
	mov	DWORD PTR [rsi], eax
	ret
	.cfi_endproc
.LFE11:
	.size	func1, .-func1
	.globl	func2
	.type	func2, @function
func2:
.LFB12:
	.cfi_startproc
	movsx	rax, edx
	lea	r11, [rdi+rax*4]
	mov	r8d, DWORD PTR [r11]
	lea	eax, [rsi-1]
	cmp	edx, esi
	jle	.L3
	movsx	r9, esi
	lea	rcx, [rdi+r9*4]
	sub	edx, esi
	lea	edx, [rdx-1]
	add	rdx, r9
	lea	rsi, [rdi+4+rdx*4]
	jmp	.L5
.L4:
	add	rcx, 4
	cmp	rcx, rsi
	je	.L3
.L5:
	mov	edx, DWORD PTR [rcx]
	cmp	edx, r8d
	jg	.L4
	add	eax, 1
	movsx	r9, eax
	lea	r9, [rdi+r9*4]
	mov	r10d, DWORD PTR [r9]
	mov	DWORD PTR [r9], edx
	mov	DWORD PTR [rcx], r10d
	jmp	.L4
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
.LFE12:
	.size	func2, .-func2
	.globl	func3
	.type	func3, @function
func3:
.LFB13:
	.cfi_startproc
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
	mov	r13, rdi
	mov	ebx, esi
	mov	r12d, edx
	cmp	edx, esi
	jle	.L7
.L9:
	mov	edx, r12d
	mov	esi, ebx
	mov	rdi, r13
	call	func2
	mov	ebp, eax
	lea	edx, [rax-1]
	mov	esi, ebx
	mov	rdi, r13
	call	func3
	lea	ebx, [rbp+1]
	cmp	ebx, r12d
	jl	.L9
.L7:
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
.LFE13:
	.size	func3, .-func3
	.ident	"GCC: (GNU) 11.3.0"
	.section	.note.GNU-stack,"",@progbits

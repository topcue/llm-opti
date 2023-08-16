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
	mov	r9, rdi
	movsx	rax, edx
	lea	r11, [rdi+rax*4]
	mov	r8d, DWORD PTR [r11]
	lea	edi, [rsi-1]
	cmp	edx, esi
	jle	.L6
	movsx	r10, esi
	lea	rcx, [r9+r10*4]
	sub	edx, esi
	lea	eax, [rdx-1]
	add	rax, r10
	lea	rdx, [r9+4+rax*4]
	jmp	.L5
.L4:
	add	rcx, 4
	cmp	rdx, rcx
	je	.L8
.L5:
	mov	eax, DWORD PTR [rcx]
	cmp	eax, r8d
	jg	.L4
	add	edi, 1
	movsx	rsi, edi
	lea	rsi, [r9+rsi*4]
	mov	r10d, DWORD PTR [rsi]
	mov	DWORD PTR [rsi], eax
	mov	DWORD PTR [rcx], r10d
	jmp	.L4
.L8:
	lea	eax, [rdi+1]
	mov	r8d, DWORD PTR [r11]
.L3:
	movsx	rdi, edi
	lea	rdx, [r9+4+rdi*4]
	mov	ecx, DWORD PTR [rdx]
	mov	DWORD PTR [rdx], r8d
	mov	DWORD PTR [r11], ecx
	ret
.L6:
	mov	eax, esi
	jmp	.L3
	.cfi_endproc
.LFE12:
	.size	func2, .-func2
	.globl	func3
	.type	func3, @function
func3:
.LFB13:
	.cfi_startproc
	cmp	esi, edx
	jl	.L15
	ret
.L15:
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
.LFE13:
	.size	func3, .-func3
	.ident	"GCC: (GNU) 11.3.0"
	.section	.note.GNU-stack,"",@progbits

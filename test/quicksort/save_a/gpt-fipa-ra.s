	.file	"quicksort.c"
	.intel_syntax noprefix
	.text
	.globl	swap
	.type	swap, @function
swap:
	.cfi_startproc
	mov	eax, DWORD PTR [rdi]
	xchg	eax, DWORD PTR [rsi]
	mov	DWORD PTR [rdi], eax
	ret
	.cfi_endproc

	.globl	partition
	.type	partition, @function
partition:
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
	inc	eax
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
	inc	eax
	ret
	.cfi_endproc

	.globl	quicksort
	.type	quicksort, @function
quicksort:
	.cfi_startproc
	cmp	esi, edx
	jl	.L13
	ret
.L13:
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	mov	r12, rdi
	mov	r13d, esi
	mov	ebx, edx
	call	partition
	mov	ebp, eax
	lea	edx, [rax-1]
	mov	esi, r13d
	mov	rdi, r12
	call	quicksort
	lea	esi, [rbp+1]
	mov	edx, ebx
	mov	rdi, r12
	call	quicksort
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.cfi_endproc


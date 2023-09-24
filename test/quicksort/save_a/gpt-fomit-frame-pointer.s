	.file	"quicksort.c"
	.intel_syntax noprefix
	.text
	.globl	swap
	.type	swap, @function
swap:
	sub	rsp, 32
	mov	QWORD PTR [rsp], rdi
	mov	QWORD PTR [rsp+8], rsi
	mov	rax, QWORD PTR [rsp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rsp+16], eax
	mov	rax, QWORD PTR [rsp+8]
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rsp]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR [rsp+8]
	mov	edx, DWORD PTR [rsp+16]
	mov	DWORD PTR [rax], edx
	add	rsp, 32
	ret

	.globl	partition
	.type	partition, @function
partition:
	sub	rsp, 48
	mov	QWORD PTR [rsp], rdi
	mov	DWORD PTR [rsp+8], esi
	mov	DWORD PTR [rsp+12], edx
	mov	eax, DWORD PTR [rsp+12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rsp+16], eax
	mov	eax, DWORD PTR [rsp+8]
	sub	eax, 1
	mov	DWORD PTR [rsp+24], eax
	mov	eax, DWORD PTR [rsp+8]
	mov	DWORD PTR [rsp+28], eax
	jmp	.L3
.L5:
	mov	eax, DWORD PTR [rsp+28]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR [rsp+16], eax
	jl	.L4
	add	DWORD PTR [rsp+24], 1
	mov	eax, DWORD PTR [rsp+28]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp]
	add	rdx, rax
	mov	eax, DWORD PTR [rsp+24]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rsp]
	add	rax, rcx
	mov	rsi, rdx
	mov	rdi, rax
	call	swap
.L4:
	add	DWORD PTR [rsp+28], 1
.L3:
	mov	eax, DWORD PTR [rsp+28]
	cmp	eax, DWORD PTR [rsp+12]
	jl	.L5
	mov	eax, DWORD PTR [rsp+12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp]
	add	rdx, rax
	mov	eax, DWORD PTR [rsp+24]
	cdqe
	add	rax, 1
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rsp]
	add	rax, rcx
	mov	rsi, rdx
	mov	rdi, rax
	call	swap
	mov	eax, DWORD PTR [rsp+24]
	add	eax, 1
	add	rsp, 48
	ret

	.globl	quicksort
	.type	quicksort, @function
quicksort:
	sub	rsp, 40
	mov	QWORD PTR [rsp], rdi
	mov	DWORD PTR [rsp+8], esi
	mov	DWORD PTR [rsp+12], edx
	mov	eax, DWORD PTR [rsp+8]
	cmp	eax, DWORD PTR [rsp+12]
	jge	.L9
	mov	edx, DWORD PTR [rsp+12]
	mov	ecx, DWORD PTR [rsp+8]
	mov	rax, QWORD PTR [rsp]
	mov	esi, ecx
	mov	rdi, rax
	call	partition
	mov	DWORD PTR [rsp+16], eax
	mov	eax, DWORD PTR [rsp+16]
	lea	edx, [rax-1]
	mov	ecx, DWORD PTR [rsp+8]
	mov	rax, QWORD PTR [rsp]
	mov	esi, ecx
	mov	rdi, rax
	call	quicksort
	mov	eax, DWORD PTR [rsp+16]
	lea	ecx, [rax+1]
	mov	edx, DWORD PTR [rsp+12]
	mov	rax, QWORD PTR [rsp]
	mov	esi, ecx
	mov	rdi, rax
	call	quicksort
.L9:
	add	rsp, 40
	ret


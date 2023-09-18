	.file	"test.c"
	.intel_syntax noprefix
	.text
	.globl	func1
	.type	func1, @function
func1:
.LFB0:
	.cfi_startproc
	sub	rsp, 32
	mov	QWORD PTR [rsp+8], rdi
	mov	QWORD PTR [rsp], rsi
	mov	rax, QWORD PTR [rsp+8]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rsp+28], eax
	mov	rax, QWORD PTR [rsp]
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rsp+8]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR [rsp]
	mov	edx, DWORD PTR [rsp+28]
	mov	DWORD PTR [rax], edx
	nop
	add	rsp, 32
	ret
	.cfi_endproc
.LFE0:
	.size	func1, .-func1
	.globl	func2
	.type	func2, @function
func2:
.LFB1:
	.cfi_startproc
	sub	rsp, 48
	mov	QWORD PTR [rsp+24], rdi
	mov	DWORD PTR [rsp+20], esi
	mov	DWORD PTR [rsp+16], edx
	mov	eax, DWORD PTR [rsp+16]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rsp+4], eax
	mov	eax, DWORD PTR [rsp+20]
	sub	eax, 1
	mov	DWORD PTR [rsp+12], eax
	mov	eax, DWORD PTR [rsp+20]
	mov	DWORD PTR [rsp+8], eax
	jmp	.L3
.L5:
	mov	eax, DWORD PTR [rsp+8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR [rsp+4], eax
	jl	.L4
	add	DWORD PTR [rsp+12], 1
	mov	eax, DWORD PTR [rsp+8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+24]
	add	rdx, rax
	mov	eax, DWORD PTR [rsp+12]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+24]
	add	rax, rcx
	mov	rsi, rdx
	mov	rdi, rax
	call	func1
.L4:
	add	DWORD PTR [rsp+8], 1
.L3:
	mov	eax, DWORD PTR [rsp+8]
	cmp	eax, DWORD PTR [rsp+16]
	jl	.L5
	mov	eax, DWORD PTR [rsp+16]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+24]
	add	rdx, rax
	mov	eax, DWORD PTR [rsp+12]
	cdqe
	add	rax, 1
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+24]
	add	rax, rcx
	mov	rsi, rdx
	mov	rdi, rax
	call	func1
	mov	eax, DWORD PTR [rsp+12]
	add	eax, 1
	add	rsp, 48
	ret
	.cfi_endproc
.LFE1:
	.size	func2, .-func2
	.globl	func3
	.type	func3, @function
func3:
.LFB2:
	.cfi_startproc
	sub	rsp, 32
	mov	QWORD PTR [rsp+8], rdi
	mov	DWORD PTR [rsp+4], esi
	mov	DWORD PTR [rsp], edx
	mov	eax, DWORD PTR [rsp+4]
	cmp	eax, DWORD PTR [rsp]
	jge	.L9
	mov	edx, DWORD PTR [rsp]
	mov	ecx, DWORD PTR [rsp+4]
	mov	rax, QWORD PTR [rsp+8]
	mov	esi, ecx
	mov	rdi, rax
	call	func2
	mov	DWORD PTR [rsp+28], eax
	mov	eax, DWORD PTR [rsp+28]
	lea	edx, [eax-1]
	mov	ecx, DWORD PTR [rsp+4]
	mov	rax, QWORD PTR [rsp+8]
	mov	esi, ecx
	mov	rdi, rax
	call	func3
	mov	eax, DWORD PTR [rsp+28]
	lea	ecx, [eax+1]
	mov	edx, DWORD PTR [rsp]
	mov	rax, QWORD PTR [rsp+8]
	mov	esi, ecx
	mov	rdi, rax
	call	func3
.L9:
	nop
	add	rsp, 32
	ret
	.cfi_endproc
.LFE2:
	.size	func3, .-func3
	.ident	"GCC: (GNU) 11.3.0"
	.section	.note.GNU-stack,"",@progbits


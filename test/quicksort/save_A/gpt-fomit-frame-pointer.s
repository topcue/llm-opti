	.file	"test.c"
	.intel_syntax noprefix
	.text
	.globl	func1
	.type	func1, @function
func1:
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
	.globl	func2
	.type	func2, @function
func2:
	.cfi_startproc
	sub	rsp, 48
	mov	QWORD PTR [rsp+16], rdi
	mov	DWORD PTR [rsp+24], esi
	mov	DWORD PTR [rsp+32], edx
	mov	eax, DWORD PTR [rsp+32]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+16]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rsp+36], eax
	mov	eax, DWORD PTR [rsp+24]
	sub	eax, 1
	mov	DWORD PTR [rsp+44], eax
	mov	eax, DWORD PTR [rsp+24]
	mov	DWORD PTR [rsp+40], eax
	jmp	.L3
.L5:
	mov	eax, DWORD PTR [rsp+40]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+16]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR [rsp+36], eax
	jl	.L4
	add	DWORD PTR [rsp+44], 1
	mov	eax, DWORD PTR [rsp+40]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+16]
	add	rdx, rax
	mov	eax, DWORD PTR [rsp+44]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+16]
	add	rax, rcx
	mov	rsi, rdx
	mov	rdi, rax
	call	func1
.L4:
	add	DWORD PTR [rsp+40], 1
.L3:
	mov	eax, DWORD PTR [rsp+40]
	cmp	eax, DWORD PTR [rsp+32]
	jl	.L5
	mov	eax, DWORD PTR [rsp+32]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+16]
	add	rdx, rax
	mov	eax, DWORD PTR [rsp+44]
	cdqe
	add	rax, 1
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rsp+16]
	add	rax, rcx
	mov	rsi, rdx
	mov	rdi, rax
	call	func1
	mov	eax, DWORD PTR [rsp+44]
	add	eax, 1
	add	rsp, 48
	ret
	.cfi_endproc
	.globl	func3
	.type	func3, @function
func3:
	.cfi_startproc
	sub	rsp, 48
	mov	QWORD PTR [rsp+16], rdi
	mov	DWORD PTR [rsp+24], esi
	mov	DWORD PTR [rsp+32], edx
	mov	eax, DWORD PTR [rsp+24]
	cmp	eax, DWORD PTR [rsp+32]
	jge	.L9
	mov	edx, DWORD PTR [rsp+32]
	mov	ecx, DWORD PTR [rsp+24]
	mov	rax, QWORD PTR [rsp+16]
	mov	esi, ecx
	mov	rdi, rax
	call	func2
	mov	DWORD PTR [rsp+44], eax
	mov	eax, DWORD PTR [rsp+44]
	lea	edx, [rax-1]
	mov	ecx, DWORD PTR [rsp+24]
	mov	rax, QWORD PTR [rsp+16]
	mov	esi, ecx
	mov	rdi, rax
	call	func3
	mov	eax, DWORD PTR [rsp+44]
	lea	ecx, [rax+1]
	mov	edx, DWORD PTR [rsp+32]
	mov	rax, QWORD PTR [rsp+16]
	mov	esi, ecx
	mov	rdi, rax
	call	func3
.L9:
	nop
	add	rsp, 48
	ret
	.cfi_endproc
	.ident	"GCC: (GNU) 11.3.0"
	.section	.note.GNU-stack,"",@progbits

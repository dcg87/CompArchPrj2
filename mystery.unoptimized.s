	.file	"mystery.c"
	.comm	num,1600,32
	.text
	.globl	add
	.type	add, @function
add:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	addq	%rdx, %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	add, .-add
	.globl	dothething
	.type	dothething, @function
dothething:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	num(,%rax,8), %rax
	cmpq	$-1, %rax
	je	.L4
	movq	-24(%rbp), %rax
	movq	num(,%rax,8), %rax
	jmp	.L3
.L4:
	cmpq	$0, -24(%rbp)
	jne	.L6
	movq	-24(%rbp), %rax
	movq	$0, num(,%rax,8)
	jmp	.L7
.L6:
	cmpq	$1, -24(%rbp)
	jne	.L8
	movq	-24(%rbp), %rax
	movq	$1, num(,%rax,8)
	jmp	.L7
.L8:
	movq	-24(%rbp), %rax
	subq	$2, %rax
	movq	%rax, %rdi
	call	dothething
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	subq	$1, %rax
	movq	%rax, %rdi
	call	dothething
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	add
	movq	-24(%rbp), %rdx
	movq	%rax, num(,%rdx,8)
	movq	-24(%rbp), %rax
	movq	num(,%rax,8), %rax
	jmp	.L3
.L7:
.L3:
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	dothething, .-dothething
	.section	.rodata
.LC0:
	.string	"Value: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	atoi
	movl	%eax, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L10
.L11:
	movl	-4(%rbp), %eax
	cltq
	movq	$-1, num(,%rax,8)
	addl	$1, -4(%rbp)
.L10:
	cmpl	$199, -4(%rbp)
	jle	.L11
	movl	-8(%rbp), %eax
	cltq
	movq	%rax, %rdi
	call	dothething
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-11)"
	.section	.note.GNU-stack,"",@progbits

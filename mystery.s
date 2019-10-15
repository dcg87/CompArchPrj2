	.file	"mystery.c"
	.text
	.globl	add
	.type	add, @function
add:
.LFB25:
	.cfi_startproc
	leaq	(%rdi,%rsi), %rax
	ret
	.cfi_endproc
.LFE25:
	.size	add, .-add
	.globl	dothething
	.type	dothething, @function
dothething:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbx
	movq	num(,%rdi,8), %rdx
	movq	%rdx, %rax
	cmpq	$-1, %rdx
	jne	.L2
	testq	%rdi, %rdi
	jne	.L4
	movq	$0, num(%rip)
	jmp	.L5
.L4:
	cmpq	$1, %rdi
	jne	.L6
	movq	$1, num+8(%rip)
	jmp	.L5
.L6:
	leaq	-2(%rdi), %rdi
	call	dothething
	movq	%rax, %rbp
	leaq	-1(%rbx), %rdi
	call	dothething
	addq	%rbp, %rax
	movq	%rax, num(,%rbx,8)
	jmp	.L2
.L5:
.L2:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE26:
	.size	dothething, .-dothething
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Value: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB27:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rsi), %rdi
	movl	$0, %eax
	call	atoi
	movl	$num, %edx
	movl	$num+1600, %esi
	movq	$-1, %rcx
.L11:
	movq	%rcx, (%rdx)
	addq	$8, %rdx
	cmpq	%rsi, %rdx
	jne	.L11
	movslq	%eax, %rdi
	call	dothething
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE27:
	.size	main, .-main
	.comm	num,1600,32
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-11)"
	.section	.note.GNU-stack,"",@progbits

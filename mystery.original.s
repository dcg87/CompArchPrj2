	.file	"mystery.c"
	.comm	num,1600,32
	.text
	.globl	add
	.type	add, @function
add:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp  
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)  # store fib(n-2) sum
	movq	%rsi, -16(%rbp) # store fib(n-1) sum
	movq	-16(%rbp), %rax  # fib(n-1) --> rax
	movq	-8(%rbp), %rdx  # fib(n-2) --> rdx
	addq	%rdx, %rax # fib(n-2) + fib(n-1) --> rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret   # return rax
	.cfi_endproc
.LFE2:
	.size	add, .-add
	.globl	dothething
	.type	dothething, @function
dothething:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx   # save current fib sum
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)  # store n
	movq	-40(%rbp), %rax  # n -> rax
	movq	num(,%rax,8), %rax  # arr[n] --> rax
	cmpq	$-1, %rax   # arr[n] == -1?
	je	.L4 
	movq	-40(%rbp), %rax  # n --> rax
	movq	num(,%rax,8), %rax  # arr[n] --> rax
	jmp	.L5
.L4:  # case: arr[n] == -1
	movq	$-1, -24(%rbp)  # store -1 
	cmpq	$0, -40(%rbp) # n == 0 ?
	jne	.L6
	movq	$0, -24(%rbp) # store 0
	jmp	.L7
.L6:  # case: arr[n] == -1 &&  n != 0
	cmpq	$1, -40(%rbp) # n == 1?
	jne	.L8
	movq	$1, -24(%rbp)  # store 1
	jmp	.L7
.L8:  #case: arr[n] == -1 && n != 0 && n != 1
	movq	-40(%rbp), %rax  # n --> rax
	subq	$2, %rax # n-2 --> rax
	movq	%rax, %rdi # pass n-2
	call	dothething
	movq	%rax, %rbx # fib(n) --> rbx
	movq	-40(%rbp), %rax  # n --> rax
	subq	$1, %rax # n-1 --> rax
	movq	%rax, %rdi  # pass n-1
	call	dothething 
	movq	%rbx, %rsi  # pass fib(n-1)
	movq	%rax, %rdi # pass  fib(n-2)
	call	add # fib(n-1) sum + fib(n-2) sum --> rax
	movq	%rax, -24(%rbp) # store current fib sum 
.L7:  # case: arr[n] == -1  && n == 0
	movq	-40(%rbp), %rax   # n --> rax
	movq	num(,%rax,8), %rax  # arr[n] --> rax
	cmpq	$-1, %rax   # arr[n] == -1?
	jne	.L9
	movq	-40(%rbp), %rax   # n --> rax
	movq	-24(%rbp), %rdx  # current fib sum --> rdx
	movq	%rdx, num(,%rax,8) # current fib sum --> arr[n]
.L9:  # arr[n] != -1
	movq	-40(%rbp), %rax  # n --> rax
	movq	num(,%rax,8), %rax # arr[n] --> rax
.L5:  # case: arr[n] != -1
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	dothething, .-dothething
	.section	.rodata
.LC0:
	.string	"Value:   %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)  # store argc
	movq	%rsi, -32(%rbp) # store argv[]
	movq	-32(%rbp), %rax # &argv[0] --> rax
	addq	$8, %rax  # &argv[1] --> rax
	movq	(%rax), %rax #  argv[1] --> rax
	movq	%rax, %rdi  # pass argv[1]
	call	atoi  # argv[1](int) --> rax
	movl	%eax, -8(%rbp) # store n
	movl	$0, -4(%rbp) # store 0
	jmp	.L11
.L12:
	movl	-4(%rbp), %eax  #  i --> eax
	cltq
	movq	$-1, num(,%rax,8) # -1 --> arr[i]
	addl	$1, -4(%rbp)  # i++; 
.L11:
	cmpl	$199, -4(%rbp)  # 199 > i? fill entire array with -1
	jle	.L12
	movl	-8(%rbp), %eax  # n --> eax
	cltq
	movq	%rax, %rdi  # pass n
	call	dothething  
	movq	%rax, %rsi # pass fib(n)
	movl	$.LC0, %edi # pass "Value: %d\n"
	movl	$0, %eax 
	call	printf   # print value
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-4)"
	.section	.note.GNU-stack,"",@progbits

.globl nCr
	.type nCr, @function
nCr:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp   
	movl	%edi, -36(%rbp)  # store n
	movl	%esi, -40(%rbp)  # store r
	movl	%edi, %eax   # n --> eax
	call	Factorial  
	movl	%eax, -20(%rbp) # store factorial(n)
	movl	-40(%rbp), %eax # r --> eax
	movl	%eax, %edi # pass r to factorial
	call	Factorial
	movl	%eax, %ebx  # factorial(r) --> ebx
	movl	-40(%rbp), %eax  #  get r 
	movl	-36(%rbp), %edx  # get n
	subl	%eax, %edx  # n - r
	movl	%edx, %eax # n - r --> eax
	movl	%eax, %edi # pass n-r to factorial
	call	Factorial
	imull	%ebx, %eax  # fact(r) * fact(n-r) --> eax
	movl	%eax, -24(%rbp) # store fact(r) * fact(n-r)
	movl	-20(%rbp), %eax # get factorial(n)
	cltd
	idivl	-24(%rbp) # fact(n) / ( fact(r) * fact(n-r) ) 
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	ret
.globl Factorial
	.type Factorial, @function
Factorial:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -20(%rbp) # get n
	movl	$1, -4(%rbp) # sum = 1
	jmp	Exit
Loop:
	movl	-4(%rbp), %eax # get current sum
	imull	-20(%rbp), %eax  #  sum *= n 
	movl	%eax, -4(%rbp) # store updated sum 
	subl	$1, -20(%rbp) # n--
Exit:
	cmpl	$0, -20(%rbp) # n > 0 ?
	jg      Loop	
	movl	-4(%rbp), %eax #return sum
	popq	%rbp
	ret

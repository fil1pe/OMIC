	#posições na stack
	.equ ptrStr, -8
	.equ localSize, -16

	.section .rodata
scanfFormat:
	.string "%s"
printfFormat:
	.string "%s\n"

	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp

	# le string
	leaq ptrStr(%rbp), %rsi
	movq $scanfFormat, %rdi
	movq $0, %rax
	call scanf

	# chama to_upper
	leaq ptrStr(%rbp), %rdi
	call to_lower

	# imprime string
	leaq ptrStr(%rbp), %rsi
	movq $printfFormat, %rdi
	movq $0, %rax
	call printf

	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

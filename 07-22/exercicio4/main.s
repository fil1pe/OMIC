	#posições na stack
	.equ inteiro, -4
	.equ localSize, -16

	.section .rodata
scanfFormat:
	.string "%i"
printfFormat:
	.string "%i\n"

	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp
loop:
	# le inteiro n
	leaq inteiro(%rbp), %rsi
	movq $scanfFormat, %rdi
	movq $0, %rax
	call scanf

	movl inteiro(%rbp), %edi

	# se n < 0, saia
	cmpl $0, %edi
	jl fim

	# chama fibonacci(n)
	call fibonacci

	# imprime fibonacci(n)
	movl %eax, %esi
	movq $printfFormat, %rdi
	movq $0, %rax
	call printf

	jmp loop
fim:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

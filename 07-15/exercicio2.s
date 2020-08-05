	#posições na stack
	.equ inteiro1, -4
	.equ inteiro2, -8			# posicao do inteiro2
	.equ localSize, -16

	.section .rodata
prompt:
	.string "Digite dois inteiros: "
scanFormat:
	.string "%i %i"
printFormat:
	.string "Soma: %i\n"

	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp

	movq $prompt, %rdi
	movq $0, %rax
	call printf

	leaq inteiro2(%rbp), %rdx	# novo parametro
	leaq inteiro1(%rbp), %rsi
	movq $scanFormat, %rdi
	movq $0, %rax
	call scanf

	movl inteiro1(%rbp), %esi
	add inteiro2(%rbp), %esi	# soma os dois numeros
	movq $printFormat, %rdi
	movq $0, %rax
	call printf

	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

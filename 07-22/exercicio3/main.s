	#posições na stack
	.equ int1, -4
	.equ int2, -8
	.equ sum, -12
	.equ localSize, -16

	.section .rodata
promptFormat:
	.string "Digite dois inteiros para somar: "
scanfFormat:
	.string "%i %i"
printf1Format:
	.string "Soma: %i\n"
printf2Format:
	.string "Overflow!\n"

	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp

	# pede para o usuario digitar
	movq $promptFormat, %rdi
	movq $0, %rax
	call printf

	# le os inteiros valor1 e valor2
	leaq int2(%rbp), %rdx
	leaq int1(%rbp), %rsi
	movq $scanfFormat, %rdi
	movq $0, %rax
	call scanf

	movl $0, sum(%rbp)

	# chama sumInts
	leaq sum(%rbp), %rdx
	movl int2(%rbp), %esi
	movl int1(%rbp), %edi
	call sumInts

	# ve se ha overflow
	cmpq $0, %rax
	je soma
overflow:
	# informa o overflow
	movq $printf2Format, %rdi
	movq $0, %rax
	call printf
	jmp fim
soma:
	# informa a soma (sem overflow)
	movl sum(%rbp), %esi
	movq $printf1Format, %rdi
	movq $0, %rax
	call printf
fim:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

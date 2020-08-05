	.equ str, -12
	.equ localSize, -16

	.text
	.globl int2ascii
	.type int2ascii, @function
int2ascii:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp

	# char *str em rsi
	# int n em edi

	movl $10, %ecx

	leaq str(%rbp), %r8
	movl $0, %r9d		# conta digitos

	cmpl $0, %edi
	jge sem_sinal		# se n eh positivo, pule
	movb $45, (%rsi)
	incq %rsi			# escreva o '-' em str
	negl %edi			# n <- |n|

sem_sinal:
	movl %edi, %eax

conv_loop:
	movl $0, %edx
	divl %ecx			# divide n por 10

	add $48, %edx		# converte o digito no resto para ascii

	movb %dl, (%r8)
	incq %r8			# escreve o digito na pilha

	incl %r9d			# conta digito

	cmpl $0, %eax
	je conv_fim			# se o quociente eh zero, pule
	jmp conv_loop

conv_fim:
	decq %r8			# volta para o ultimo digito escrito na pilha

inverte:
	movb (%r8), %dl
	movb %dl, (%rsi)
	incq %rsi			# escreve o digito atual da pilha

	decq %r8			# volta um digito

	decl %r9d
	cmpl $0, %r9d
	jne inverte			# se --contador eh zero, pare
fim:
	movb $0, (%rsi)		# escreve '\0'

	movq %rbp, %rsp
	popq %rbp
	ret

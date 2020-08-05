.text
	.globl dec2ascii
	.type dec2ascii, @function
dec2ascii:
    # prólogo
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	# char *str em rsi

	movl $10, %ecx

	leaq -8(%rbp), %r8
	movl $0, %r9d		# inicializa contador de dígitos

	cmpl $0, %edi
	jge sem_sinal		# se não é negativo, pula
	movb $45, (%rsi)
	incq %rsi			# escreve o '-' em str
	negl %edi			# n <- |n|

sem_sinal:
	movl %edi, %eax     # move n para eax

conv_loop:
	movl $0, %edx
	divl %ecx			# divide n por 10

	add $48, %edx		# converte o dígito no resto para ascii

	movb %dl, (%r8)
	incq %r8			# escreve o dígito na pilha

	incl %r9d			# incrementa o contador

	cmpl $0, %eax
	je conv_fim			# se o quociente é zero, sai do loop

	jmp conv_loop

conv_fim:
	decq %r8			# volta para o último dígito escrito na pilha

inverte:
	movb (%r8), %dl
	movb %dl, (%rsi)
	incq %rsi			# escreve o dígito atual da pilha

	decq %r8			# volta um dígito

	decl %r9d           # decrementa contador

	cmpl $0, %r9d
	jne inverte			# se o contador está em zero, pare
fim:
	movb $0, (%rsi)		# escreve '\0'

    # epílogo
	movq %rbp, %rsp
	popq %rbp
	ret

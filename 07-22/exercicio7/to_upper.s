	#posicoes na pilha
	.equ ptrStr,-8
	.equ ptrStr1, -16
	.equ localSize,-16

	.text
	.globl to_upper
	.type to_upper, @function
to_upper:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp

	# rdi contem a string (ponteiro)

	movq %rdi, %rsi				# carrega o end. base para rsi
	movq %rsi, ptrStr(%rbp)		# armazena o end. da string na pilha
	movq %rsi, ptrStr1(%rbp)	# armazena o end. da string na pilha (de novo)
loop:
	movq ptrStr1(%rbp), %rsi	# carrega a posicao atual para rsi
	cmpb $0, (%rsi)				# o valor na posicao eh \0?
	je fimLoop					# se sim, salte

	cmpb $97, (%rsi)			# se o valor na posicao vem antes de a na ascii
	jl fazNada					# salte
	cmpb $122, (%rsi)			# se o valor na posicao vem depois de z na ascii
	jg fazNada					# salte
	andb $0xDF, (%rsi)			# torna maiuscula
fazNada:
	incl ptrStr1(%rbp)			# incrementa o ponteiro
	jmp loop
fimLoop:
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret

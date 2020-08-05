	#posicoes na pilha
	.equ ptrStr,-8
	.equ ptrStr1, -16
	.equ localSize,-16

	.text
	.globl to_lower
	.type to_lower, @function
to_lower:
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

	cmpb $65, (%rsi)			# se o valor na posicao vem antes de A na ascii
	jl fazNada					# salte
	cmpb $90, (%rsi)			# se o valor na posicao vem depois de Z na ascii
	jg fazNada					# salte
	orb $0x20, (%rsi)			# torna minuscula
fazNada:
	incl ptrStr1(%rbp)			# incrementa o ponteiro
	jmp loop
fimLoop:
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret

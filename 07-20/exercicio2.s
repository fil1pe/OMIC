#constantes
	.equ STDIN,0
	.equ STDOUT,1
	.equ READ,0
	.equ WRITE,1
	.equ EXIT,60
#posicoes na pilha
	.equ str, -16
	.equ ptrStr,-24
	.equ ptrStr1, -32
	.equ strSize, -40
	.equ localSize,-48

	.section .rodata
prompt:
	.string "Digite algo: "
	.equ promptSz, .-prompt-1
msg:
	.string "Em maiusculo: "
	.equ msgSz, .-msg-1
break:
	.string "\n"
	.equ breakSz, 1

	.text
	.globl __start
__start:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp

	# pede para o usuario digitar
	movq $promptSz,%rdx
	movq $prompt,%rsi
	movq $STDOUT,%rdi
	movl $WRITE, %eax
	syscall

	# le a string
	movq $15,%rdx
	leaq str(%rbp),%rsi
	movq $STDIN, %rdi
	movl $READ, %eax
	syscall

	# imprime a mensagem
	movq $msgSz, %rdx
	movq $msg, %rsi
	movq $STDOUT, %rdi
	movl $WRITE, %eax
	syscall

	leaq str(%rbp), %rsi		# carrega o end. base para rsi
	movq %rsi, ptrStr(%rbp)		# armazena o end. da string na pilha
	movq %rsi, ptrStr1(%rbp)	# armazena o end. da string na pilha (de novo)
	movq $0, strSize(%rbp)		# armazena o tamanho lido da string
while:
	movq ptrStr1(%rbp), %rsi	# carrega a posicao atual para rsi
	cmpb $0, (%rsi)				# o valor na posicao eh \0?
	je fimLoop					# se sim, salte
	cmpb $10, (%rsi)			# o valor na posicao eh \n?
	je fimLoop					# se sim, salte

	cmpb $97, (%rsi)			# se o valor na posicao vem antes de a na ascii
	jl fazNada					# salte
	cmpb $122, (%rsi)			# se o valor na posicao vem depois de z na ascii
	jg fazNada					# salte
	addq $-32, (%rsi)			# torna maiuscula
fazNada:
	incl strSize(%rbp)			# incrementa o tamanho lido da string
	incl ptrStr1(%rbp)			# incrementa o ponteiro
	jmp while
fimLoop:
	# imprime a string alterada
	movq strSize(%rbp), %rdx
	leaq str(%rbp), %rsi
	movq $STDOUT, %rdi
	movl $WRITE, %eax
	syscall

	# pula linha
	movq $1, %rdx
	movq $break, %rsi
	movq $STDOUT, %rdi
	movl $WRITE, %eax
	syscall

	movq %rbp, %rsp
	popq %rbp
	movq $0, %rdi
	movl $EXIT, %eax
	syscall

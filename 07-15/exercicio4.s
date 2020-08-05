#constantes
	.equ STDIN,0
	.equ STDOUT,1
	.equ READ,0
	.equ WRITE,1
	.equ EXIT,60
#posicoes na pilha
	.equ aLetter,-16
	.equ localSize,-16

	.section .rodata
prompt:
	.string "Digite um caractere: "
	.equ promptSz,.-prompt-1
msg:
	.string "Em maiusculo: "
	.equ msgSz,.-msg-1

	.text
	.globl __start
__start:
	pushq %rbp
	movq %rsp,%rbp
	addq $localSize,%rsp

	movq $promptSz,%rdx
	movq $prompt,%rsi
	movq $STDOUT,%rdi
	movl $WRITE, %eax
	syscall

	movq $2,%rdx
	leaq aLetter(%rbp),%rsi
	movq $STDIN, %rdi
	movl $READ, %eax
	syscall

	movq $msgSz, %rdx
	movq $msg, %rsi
	movq $STDOUT, %rdi
	movl $WRITE, %eax
	syscall

	movq aLetter(%rbp), %rsi	# coloca os caracteres em rsi
	addq $-32, %rsi				# transforma em maiusculo o primeiro (ver ascii)
	movq %rsi, aLetter(%rbp)	# coloca o novo caractere na pilha

	movq $2, %rdx
	leaq aLetter(%rbp), %rsi
	movq $STDOUT, %rdi
	movl $WRITE, %eax
	syscall

	movq %rbp, %rsp
	popq %rbp
	movq $0, %rdi
	movl $EXIT, %eax
	syscall

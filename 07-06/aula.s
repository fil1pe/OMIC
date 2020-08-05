	#constantes
	.equ STDOUT, 1
	
	.section .rodata
ola_mundo:
	.string "Ola mundo cruel\n"
	.equ ola_size, .-ola_mundo-1
	
	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	
	movl $STDOUT, %edi
	movq $ola_mundo, %rsi
	movl $ola_size, %edx
	call write
	
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

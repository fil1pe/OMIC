	#constantes
	.equ STDOUT, 1
	.equ STDIN, 0
	.equ localSize, -16
	.equ aLetter, -16
	
	.section .rodata
str_entre:
	.string "Entre com um caractere: "
	.equ str_entreSz, .-str_entre-1
	
	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp
	
	movl $str_entreSz, %edx
	movq $str_entre, %rsi
	movl $STDOUT, %edi
	call write
	
	movl $2, %edx
	#leaq aLetter(%rbp), %rsi
	movq %rbp, %rsi
	add $aLetter, %rsi
	movl $STDIN, %edi
	call read
	
	movl $2, %edx
	#leaq aLetter(%rbp), %rsi
	movq %rbp, %rsi
	add $aLetter, %rsi
	movl $STDOUT, %edi
	call write
	
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

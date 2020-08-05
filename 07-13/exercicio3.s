	#constantes
	.equ STDOUT, 1
	.equ STDIN, 0
	.equ localSize, -16
	.equ aLetter, -13
	.equ bLetter, -16
	
	.section .rodata
str_entre1:
	.string "Entre com uma palavra de 3 caracteres: "
	.equ str_entre1Sz, .-str_entre1-1
str_entre2:
	.string "Entre com uma palavra de 2 caracteres: "
	.equ str_entre2Sz, .-str_entre2-1
	
	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $localSize, %rsp
	
	# Imrpime str_entre1:
	movl $str_entre1Sz, %edx
	movq $str_entre1, %rsi
	movl $STDOUT, %edi
	call write
	
	# Lê três caracteres + '\n' a partir de -13 bytes de rbp:
	movl $4, %edx
	leaq aLetter(%rbp), %rsi
	movl $STDIN, %edi
	call read
	
	# Imrpime str_entre2:
	movl $str_entre2Sz, %edx
	movq $str_entre2, %rsi
	movl $STDOUT, %edi
	call write
	
	# Lê dois caracteres + '\n' a partir de -16 bytes de rbp:
	movl $3, %edx
	leaq bLetter(%rbp), %rsi
	movl $STDIN, %edi
	call read
	
	# Imprime a concatenação das strings lidas:
	movl $7, %edx
	leaq bLetter(%rbp), %rsi
	movl $STDOUT, %edi
	call write
	
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

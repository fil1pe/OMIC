	.section .rodata
fmt:
	.string "%s"
ola_mundo:
	.string "Ola mundo\n"

	.text
	.globl main
	.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp

	#printf(fmt, ola_mundo)
	movq $fmt, %rdi			#primeiro argumento
	movq $ola_mundo, %rsi	#segundo argumento
	movq $0, %rax
	call printf

	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret

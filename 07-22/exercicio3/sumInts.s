	.text
	.globl sumInts
	.type sumInts, @function
sumInts:
	pushq %rbp
	movq %rsp, %rbp

	# rdx contem *soma
	# esi contem valor2
	# edi contem valor1

	# faz a soma
	movl %edi, %ecx
	add %esi, %ecx

	jno sem_overflow # checa overflow
com_overflow:
	movq $1, %rax
	jmp fim
sem_overflow:
	movq %rcx, (%rdx)
	movq $0, %rax
fim:
	movq %rbp, %rsp
	popq %rbp
	ret

	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	pushq %rbp
	movq %rsp, %rbp

	# rdi contem n

	cmpq $0, %rdi
	je fib_0

	movq $1, %r8		# contador

	movq $0, %rsi		# a
	movq $1, %rdx		# b
	jmp loop
fib_0:
	movq $0, %rax
	jmp fim
loop:
	cmpq %r8, %rdi
	je fim_loop			# salta se contador == n
	movq %rdx, %rcx		# aux <- b
	addq %rsi, %rdx		# b <- b + a
	movq %rcx, %rsi		# a <- aux
	incq %r8			# contador++
	jmp loop
fim_loop:
	movq %rdx, %rax		# retorna b
fim:
	movq %rbp, %rsp
	popq %rbp
	ret

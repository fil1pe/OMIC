	.text
	.globl dividir
	.type dividir, @function
dividir:
	pushq %rbp
	movq %rsp, %rbp

	movq %rdx, %rcx		# copia rdx para auxiliar
	movl %edi, %eax		# os 4 bytes para eax
	cdq					# os 4 bytes mais altos completados com zeros ou uns dependendo do sinal de eax
	idivl %esi			# divisor em esi
	movl %edx, (%rcx)	# copia o resto para o endereço em rcx

	movq %rbp, %rsp
	popq %rbp
	ret

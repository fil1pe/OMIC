	.text
	.globl main
main:
	# -----
	li $v0, 5
	syscall
	ori $a0, $v0, 0			# lê n do usuário
	# -----
	jal fib
	# -----
	ori $a0, $v0, 0
	li $v0, 1
	syscall				# imprime fib(n)
	# -----
end:
	li $v0, 10
	syscall
fib:
	# -----
	li $t0, 1
	blt $t0, $a0, calcula_fib	# se n > 1, vai para calcula_fib
	# -----
	li $v0, 1			# retorna 1
	jr $ra
calcula_fib:
	addi $sp, $sp, -4		# aloca espaço para o fp
	sw $fp, 0($sp)			# salva o fp antigo
	ori $fp, $sp, 0			# coloca o início do frame em fp
	addi $sp, $sp, -8		# aloca espaço para dois itens
	sw $ra, -4($fp)			# salva o endereço de retorno
	sw $a0, -8($fp)			# salva o argumento n
	addi $a0, $a0, -1		# a0 <- n - 1
	jal fib				# chama a recursiva fib(n-1)
	lw $a0, -8($fp)			# restaura n em a0
	sw $v0, -8($fp)			# salva fib(n-1)
	addi $a0, $a0, -2		# a0 <- n - 2
	jal fib				# chama a recursiva fib(n-2)
	lw $t0, -8($fp)			# restaura fib(n-1) em t0
	lw $ra, -4($fp)			# restaura o endereço de retorno
	lw $fp, 0($fp)			# restaura o fp antigo
	addi $sp, $sp, 12		# desaloca o frame
	add $v0, $v0, $t0		# retorna fib(n-1) + fib(n-2)
	jr $ra

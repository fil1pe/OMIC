	.text
	.globl main
main:
	# -----
	li $v0, 5
	syscall
	ori $a0, $v0, 0			# lê n do usuário
	# -----
	jal soma
	# -----
	ori $a0, $v0, 0
	li $v0, 1
	syscall				# imprime soma(n)
	# -----
end:
	li $v0, 10
	syscall
soma:
	# -----
	li $t0, 9
	blt $t0, $a0, calcula_soma	# se n > 9, vai para calcula_soma
	# -----
	ori $v0, $a0, 0			# retorna n
	jr $ra
calcula_soma:
	addi $sp, $sp, -4		# aloca espaço para o fp
	sw $fp, 0($sp)			# salva o fp antigo
	ori $fp, $sp, 0			# coloca o início do frame em fp
	addi $sp, $sp, -8		# aloca espaço para dois itens
	sw $ra, -4($fp)			# salva o endereço de retorno
	# -----
	li $t0, 10
	div $a0, $t0
	mflo $a0			# a0 <- (int) n / 10
	# -----
	mfhi $t0			# n % 10 é o dígito mais à direita
	sw $t0, -8($fp)			# salva n % 10
	# -----
	jal soma			# chama a recursiva soma((int) n/10)
	lw $t0, -8($fp)			# restaura n % 10
	lw $ra, -4($fp)			# restaura o endereço de retorno
	lw $fp, 0($fp)			# restaura o fp antigo
	addi $sp, $sp, 12		# desaloca o frame
	add $v0, $v0, $t0		# retorna (n % 10) + soma((int) n/10)
	jr $ra
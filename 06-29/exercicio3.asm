	.text
	.globl main
main:
	# -----
	la $a0, texto_0
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	ori $s0, $v0, 0			# lê k do usuário
	# -----
	la $a0, texto_1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	ori $a1, $v0, 0			# lê n do usuário
	# -----
	ori $a0, $s0, 0
	jal conta
	# -----
	ori $a0, $v0, 0
	li $v0, 1
	syscall				# imprime conta(k, n)
	# -----
end:
	li $v0, 10
	syscall
conta:
	# -----
	li $t0, 9
	blt $t0, $a1, calcula_conta	# se n > 9, vai para calcula_conta
	# -----
	seq $v0, $a0, $a1		# retorna 1 se n = z ou 0 caso contrário
	jr $ra
calcula_conta:
	addi $sp, $sp, -4		# aloca espaço para o fp
	sw $fp, 0($sp)			# salva o fp antigo
	ori $fp, $sp, 0			# coloca o início do frame em fp
	addi $sp, $sp, -8		# aloca espaço para dois itens
	sw $ra, -4($fp)			# salva o endereço de retorno
	# -----
	li $t0, 10
	div $a1, $t0
	mflo $a1			# a1 <- (int) n / 10
	# -----
	mfhi $t0			# n % 10 é o dígito mais à direita
	seq $t0, $a0, $t0		# x=1 se n%10=k ou x=0 caso contrário
	sw $t0, -8($fp)			# salva x
	# -----
	jal conta			# chama a recursiva conta(k, (int) n/10)
	lw $t0, -8($fp)			# restaura x
	lw $ra, -4($fp)			# restaura o endereço de retorno
	lw $fp, 0($fp)			# restaura o fp antigo
	addi $sp, $sp, 12		# desaloca o frame
	add $v0, $v0, $t0		# retorna x + conta(k, (int) n/10)
	jr $ra

	.data
texto_0:
	.asciiz "Digite K: "
texto_1:
	.asciiz "Digite N: "
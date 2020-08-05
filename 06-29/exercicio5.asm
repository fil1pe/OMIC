	.text
	.globl main
main:
	# -----
	li $v0, 5
	syscall
	ori $a0, $v0, 0			# lê n do usuário
	# -----
	jal dec2bin
	# -----
	ori $a0, $v0, 0
	li $v0, 1
	syscall				# imprime dec2bin(n)
	# -----
end:
	li $v0, 10
	syscall
dec2bin:
	# -----
	li $t0, 2
	ble $t0, $a0, calcula_dec2bin
	# -----
	ori $v0, $a0, 0
	jr $ra
calcula_dec2bin:
	addi $sp, $sp, -4		# aloca espaço para o fp
	sw $fp, 0($sp)			# salva o fp antigo
	ori $fp, $sp, 0			# coloca o início do frame em fp
	addi $sp, $sp, -8		# aloca espaço para dois itens
	sw $ra, -4($fp)			# salva o endereço de retorno
	# -----
	li $t0, 2
	div $a0, $t0
	mflo $a0			# a0 <- (int) n / 2
	# -----
	mfhi $t0
	sw $t0, -8($fp)			# salva n % 2
	# -----
	jal dec2bin			# chama a recursiva dec2bin((int) n/2)
	lw $t0, -8($fp)			# restaura n % 2
	lw $ra, -4($fp)			# restaura o endereço de retorno
	lw $fp, 0($fp)			# restaura o fp antigo
	addi $sp, $sp, 12		# desaloca o frame
	# -----
	li $t1, 10
	mul $v0, $v0, $t1
	add $v0, $v0, $t0		# retorna dec2bin((int) n/2) * 10 + (n % 2)
	# -----
	jr $ra
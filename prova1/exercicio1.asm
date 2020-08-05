	.text
	.globl main
main:
	ori $v0, $zero, 5
	syscall
	ori $a0, $v0, 0
	ori $v0, $zero, 5
	syscall
	ori $a1, $v0, 0				# le A e B
	jal euclides
	ori $a0, $v0, 0
	ori $v0, $zero, 1
	syscall					# imprime mdc(A,B)
end:
	li $v0, 10
	syscall

euclides:
	addi $sp, $sp, -4			# aloca espaço na pilha
	sw $fp, 0($sp)				# salva o fp
	ori $fp, $sp, 0				# coloca o inicio do frame em $fp
	addi $sp, $sp, -4			# aloca espaço na pilha
	sw $ra, -4($fp)				# salva o end. de retorno
	beq $a1, $zero, euclides_troca		# vai para 'euclides_troca' se B = 0
	slt $t0, $a0, $a1			# t0 <- A < B
	beq $t0, $zero, euclides_continua	# vai para 'euclides_continua' se t0 tem zero
euclides_troca:
	# troca A por B
	ori $t0, $a1, 0
	ori $a1, $a0, 0
	ori $a0, $t0, 0
euclides_continua:
	beq $a0, $zero, euclides_B	# retorna B se A = 0
	div $a0, $a1			# faz a divisao A / B
	ori $a0, $a1, 0			# coloca B em A
	mfhi $a1			# coloca o resto da divisao de A por B em a1
	jal euclides			# chama a recursao
	lw $ra, -4($fp)			# restaura o end. de retorno
	lw $fp, 0($fp)			# restaura o fp antigo
	addi $sp, $sp, 8		# desaloca itens da pilha
	jr $ra
euclides_B:
	ori $v0, $a1, 0			# retorna B
	lw $fp, 0($fp)			# restaura o fp antigo
	addi $sp, $sp, 8		# desaloca itens da pilha
	jr $ra
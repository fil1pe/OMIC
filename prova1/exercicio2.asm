	.text
	.globl main
main:
	ori $s0, $zero, 1
	ori $s1, $zero, 0		# total de numeros
	ori $s2, $zero, 0		# numeros pares
leitura:
	ori $v0, $zero, 5
	syscall				# le o numero
	slt $t0, $v0, $s0
	beq $t0, $s0, fim		# se o valor lido for <= 0, vai pra 'end'
	addi $s1, $s1, 1		# incrementa o contador de numeros
	ori $a0, $v0, 0
	jal eh_par
	add $s2, $s2, $v0		# adiciona o valor retornado de eh_par em s2
	j leitura			# faz o loop
fim:
	# imprime os resultados (numeros impares = total - pares) e fim!
	ori $a0, $s2, 0
	ori $v0, $zero, 1
	syscall
	la $a0, saida1
	ori $v0, $zero, 4
	syscall
	sub $a0, $s1, $s2
	ori $v0, $zero, 1
	syscall
	la $a0, saida2
	ori $v0, $zero, 4
	syscall
end:
	li $v0, 10
	syscall
eh_par:
	ori $t0, $zero, 2
	div $a0, $t0			# faz a divisao do valor de a0 por 2
	mfhi $t0			# pega o resto da divisao
	beq $t0, $zero, eh_par_sim	# se ele e zero, retorna um, pois o valor de a0 e par
	ori $v0, $zero, 0		# retorna zero
	jr $ra
eh_par_sim:
	ori $v0, $zero, 1
	jr $ra

	.data
saida1:
	.asciiz " par(es)\n"
saida2:
	.asciiz " impar(es)"
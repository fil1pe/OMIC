	.text
	.globl main
main:
	ori $v0, $zero, 5
	syscall
	or $a0, $zero, $v0
	jal soma
	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
	j end
soma:
	ori $t0, $zero, 0
	blt $t0, $a0, soma_pos
	beq $t0, $a0, soma_pos
	ori $t0, $zero, -1
	mul $a0, $a0, $t0
soma_pos:
	ori $t0, $zero, 10
	blt $a0, $t0, soma_parada
	div $a0, $t0
	mflo $a0
	mfhi $t0
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $ra, 4($sp)
	jal soma
	lw $t0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	add $v0, $v0, $t0
	jr $ra
soma_parada:
	or $v0, $zero, $a0
	jr $ra
end:
	li $v0, 10
	syscall
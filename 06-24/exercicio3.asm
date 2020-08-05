	.text
	.globl main
main:
	ori $v0, $zero, 5
	syscall
	or $a0, $zero, $v0
	ori $v0, $zero, 5
	syscall
	or $a1, $zero, $v0
	jal conta_ocorr
	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
	j end
conta_ocorr:
	ori $t0, $zero, 0
	blt $t0, $a0, conta_ocorr_pos
	beq $t0, $a0, conta_ocorr_pos
	ori $t0, $zero, -1
	mul $a0, $a0, $t0
conta_ocorr_pos:
	ori $t0, $zero, 10
	blt $a0, $t0, conta_ocorr_parada
	div $a0, $t0
	mflo $a0
	mfhi $t0
	ori $v0, $zero, 0
	bne $t0, $a1, conta_ocorr_pos_0
	addi $v0, $v0, 1
conta_ocorr_pos_0:
	addi $sp, $sp, -8
	sw $v0, 0($sp)
	sw $ra, 4($sp)
	jal conta_ocorr
	lw $t0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	add $v0, $v0, $t0
	jr $ra
conta_ocorr_parada:
	beq $a0, $a1, conta_ocorr_parada_1
	ori $v0, $zero, 0
	jr $ra
conta_ocorr_parada_1:
	ori $v0, $zero, 1
	jr $ra
end:
	li $v0, 10
	syscall
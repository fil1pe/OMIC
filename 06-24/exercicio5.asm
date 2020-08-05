	.text
	.globl main
main:
	ori $v0, $zero, 5
	syscall
	or $a0, $zero, $v0
	jal dec2bin
	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
	j end
dec2bin:
	ori $t0, $zero, 0
	blt $t0, $a0, dec2bin_pos
	ori $t0, $zero, -1
	mul $a0, $a0, $t0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal dec2bin
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	ori $t0, $zero, -1
	mul $v0, $v0, $t0
	jr $ra
dec2bin_pos:
	ori $t0, $zero, 2
	blt $a0, $t0, dec2bin_0_1
	div $a0, $t0
	mflo $a0
	mfhi $v0
	addi $sp, $sp, -8
	sw $v0, 0($sp)
	sw $ra, 4($sp)
	jal dec2bin
	lw $t0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	ori $t1, $zero, 10
	mul $v0, $v0, $t1
	add $v0, $v0, $t0
	jr $ra
dec2bin_0_1:
	or $v0, $zero, $a0
	jr $ra
end:
	li $v0, 10
	syscall
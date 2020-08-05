	.text
	.globl main
main:
	ori $v0, $zero, 5
	syscall
	or $a0, $zero, $v0
	jal fibonacci
	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
	j end
fibonacci:
	slti $t0, $a0, 2
	bne $t0, $zero, fibonacci_0_1
	addi $sp, $sp, -12
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	addi $a0, $a0, -1
	jal fibonacci
	sw $v0, 8($sp)
	lw $a0, 0($sp)
	addi $a0, $a0, -2
	jal fibonacci
	lw $t0, 8($sp)
	add $v0, $v0, $t0
	lw $ra, 4($sp)
	addi $sp, $sp, 12
	jr $ra
fibonacci_0_1:
	ori $v0, $zero, 1
	jr $ra
end:
	li $v0, 10
	syscall
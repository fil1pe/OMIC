	.text
	.globl main
main:
	ori $v0, $zero, 5
	syscall
	blt $v0, 0, end
	or $a0, $zero, $v0
	jal fibonacci
	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
	ori $a0, $zero, 10
	ori $v0, $zero, 11
	syscall
	j main
end:
	li $v0, 10
	syscall

fibonacci:
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	ori $s0, $zero, 0
	ori $v0, $zero, 0
	ori $s1, $zero, 1
fib_loop:
	beq $s0, $a0, fib_end
	add $s2, $v0, $s1
	or $v0, $zero, $s1
	or $s1, $zero, $s2
	addi $s0, $s0, 1
	j fib_loop
fib_end:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
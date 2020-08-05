	.text
	.globl main
main:
	# read 'a'
	ori $v0, $zero, 5
	syscall
	or $a0, $zero, $v0
	# read 'b'
	ori $v0, $zero, 5
	syscall
	or $a1, $zero, $v0
	# read 'c'
	ori $v0, $zero, 5
	syscall
	or $a2, $zero, $v0
	# read 'd'
	ori $v0, $zero, 5
	syscall
	or $a3, $zero, $v0
	# read 'x'
	ori $v0, $zero, 5
	syscall
	addi $sp, $sp, -4
	sw $v0, 0($sp)
	
	jal polinomio
	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
end:
	li $v0, 10
	syscall

polinomio:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	or $s0, $zero, $a0
	or $s1, $zero, $a1
	lw $s2, 20($sp)
	ori $s3, $zero, 0
	sw $ra, 20($sp)
	
	# add 'axxx'
	or $a0, $zero, $s2
	ori $a1, $zero, 3
	jal pow
	mul $s4, $v0, $s0
	add $s3, $s3, $s4
	# add 'bxx'
	or $a0, $zero, $s2
	ori $a1, $zero, 2
	jal pow
	mul $s4, $v0, $s1
	add $s3, $s3, $s4
	# add 'cx'
	or $a0, $zero, $s2
	ori $a1, $zero, 1
	jal pow
	mul $s4, $v0, $a2
	add $s3, $s3, $s4
	# add 'd'
	or $a0, $zero, $s2
	ori $a1, $zero, 0
	jal pow
	mul $s4, $v0, $a3
	add $s3, $s3, $s4
	
	or $v0, $zero, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, 24
	jr $ra

pow:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	ori $s0, $zero, 0
	ori $v0, $zero, 1
pow_loop:
	beq $s0, $a1, pow_end
	mul $v0, $v0, $a0
	addi $s0, $s0, 1
	j pow_loop
pow_end:
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	.text
	.globl main
main:
	#read 'a'
	ori $v0, $zero, 5
	syscall
	or $a0, $zero, $v0
	#read 'b'
	ori $v0, $zero, 5
	syscall
	or $a1, $zero, $v0
	#read 'c'
	ori $v0, $zero, 5
	syscall
	or $a2, $zero, $v0
	#read 'd'
	ori $v0, $zero, 5
	syscall
	or $a3, $zero, $v0
	#read 'x'
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
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	lw $s0, 8($sp)
	sw $s1, 4($sp)
	# add 'axxx'
	mul $v0, $s0, $s0
	mul $v0, $v0, $s0
	mul $v0, $v0, $a0
	# add 'bxx'
	mul $s1, $s0, $s0
	mul $s1, $s1, $a1
	add $v0, $v0, $s1
	#add 'cx'
	mul $s1, $s0, $a2
	add $v0, $v0, $s1
	#add 'd'
	add $v0, $v0, $a3
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 12
	jr $ra
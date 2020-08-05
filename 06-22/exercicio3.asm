	.text
	.globl main
main:
	ori $v0, $zero, 5
	syscall
	or $a0, $zero, $v0
	jal conta_dig
	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
end:
	li $v0, 10
	syscall

conta_dig:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	ori $v0, $zero, 0
	ori $s0, $zero, 10
	ori $s1, $zero, 0
cd_loop:
	div $a0, $s0
	mflo $a0
	addi $v0, $v0, 1
	bne $a0, $s1, cd_loop
cd_end:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
    .text
    .globl polinomio
    .type polinomio, @function
polinomio:
    # prólogo
    pushq %rbp
	movq %rsp, %rbp
    subq $32, %rsp

    movq %rdi, -8(%rbp)     # salva o vetor
    movl %esi, -12(%rbp)    # salva n
    movl %edx, -16(%rbp)    # salva x
    movq $0, -24(%rbp)      # salva o resultado

loop:
    # se n <= 0, sai do loop
    cmpl $0, -12(%rbp)
    jle fim

    # decrementa n
    decl -12(%rbp)

    # calcula x^n
    movl -12(%rbp), %esi
    movl -16(%rbp), %edi
    call pow

    # multiplica x^n pelo coeficiente atual 
    movq -8(%rbp), %rdi
    imulq (%rdi)

    # soma ao resultado
    addq %rax, -24(%rbp)

    # aponta para o próximo coeficiente
    addq $4, -8(%rbp)

    jmp loop

fim:
    movq -24(%rbp), %rax

    # epílogo
	movq %rbp, %rsp
	popq %rbp
	ret

# função que calcula potência de x^n
    .text
    .globl pow
    .type power, @function
pow:
    # prólogo
    pushq %rbp
	movq %rsp, %rbp

    movq $1, %rcx   # armazena o resultado
pow_loop:
    # se n <= 0, sai do loop
    cmpl $0, %esi
    jle pow_fim

    # multiplica x pelo resultado anterior
    movl %edi, %eax
    mulq %rcx
    movq %rax, %rcx

    # decrementa n
    decl %esi

    jmp pow_loop
pow_fim:
    movq %rcx, %rax

    # epílogo
	movq %rbp, %rsp
	popq %rbp
	ret

    .section .rodata
prompt:
    .string "Digite o número de coeficientes de p(x): "
intFmt:
    .string "%d"
promptX:
    .string "Digite um valor para x: "
promptCoef:
    .string "Digite os coeficientes:\n"
resultFmt:
    .string "p(%d) = %d\n"
    .text
    .globl main
    .type main, @function
main:
    # prólogo
    pushq %rbp
	movq %rsp, %rbp
    subq $16, %rsp  # aloca 16 bytes para o frame

    # pede para o usuário digitar
	movq $prompt, %rdi
	movq $0, %rax
	call printf

    # lê o número de coeficientes
    leaq -4(%rbp), %rsi
    movq $intFmt, %rdi
	movq $0, %rax
	call scanf

    # salva um contador extra
    movl -4(%rbp), %eax
    cdq
    movl %eax, -8(%rbp)

    # aloca um múltiplo de 16 bytes para o vetor
    movl $4, %esi
    divl %esi
    cmpl $0, %edx
    je aloca
    incl %eax
aloca:
    movl $16, %esi
    mull %esi
    subq %rax, %rsp

    # salva o ponteiro para o fim do vetor
    leaq (%rsp), %rsi
    movq %rsi, -16(%rbp)

    # pede para o usuário digitar os coeficientes
	movq $promptCoef, %rdi
	movq $0, %rax
	call printf
    
leitura:
    cmpl $0, -8(%rbp)
    jle leitura_fim

    # lê o coeficiente
    movq -16(%rbp), %rsi
    movq $intFmt, %rdi
	movq $0, %rax
	call scanf

    # aponta para o próximo coeficiente
    addq $4, -16(%rbp)

    # decrementa o contador extra
    decl -8(%rbp)

    jmp leitura

leitura_fim:
    # pede para o usuário digitar x
	movq $promptX, %rdi
	movq $0, %rax
	call printf

    # lê x
    leaq -8(%rbp), %rsi
    movq $intFmt, %rdi
	movq $0, %rax
	call scanf

    movl -8(%rbp), %edx
    movl -4(%rbp), %esi
    leaq (%rsp), %rdi
    call polinomio

    movl %eax, %edx
    movl -8(%rbp), %esi
	movq $resultFmt, %rdi
	movq $0, %rax
	call printf

    # epílogo
    movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret

    .text
    .globl substituir
    .type substituir, @function
substituir:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

loop:
    # se for fim da string, sai do loop
    cmpb $0, (%rdi)
    je fim

    # se o caractere atual não for igual a c1, pule
    cmpb %sil, (%rdi)
    jne nao_troca

    # troca o caractere
    movb %dl, (%rdi)
nao_troca:
    incq %rdi   # aponta para o próximo caractere
    jmp loop

fim:
    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret

# constantes
    .equ STDIN,0
    .equ STDOUT,1
    .equ READ,0
    .equ WRITE,1
    .equ EXIT,60

    .section .rodata
prompt:
    .string "Digite uma string de até 50 caracteres: "
    .equ promptSz, .-prompt-1
promptC1:
    .string "Digite um caractere a ser substituído: "
    .equ promptC1Sz, .-promptC1-1
promptC2:
    .string "Digite um caractere para substituir: "
    .equ promptC2Sz, .-promptC2-1
result:
    .string "=====\nResultado: "
    .equ resultSz, .-result-1

    .text
    .globl __start
__start:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp  # aloca 64 bytes para o frame

    # pede para o usuario digitar
    movq $promptSz, %rdx
    movq $prompt, %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    # lê a string
    movq $51, %rdx
    leaq -52(%rbp), %rsi
    movq $STDIN, %rdi
    movl $READ, %eax
    syscall
    
    # pede para o usuario digitar c1
    movq $promptC1Sz, %rdx
    movq $promptC1, %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    # lê c1
    movq $2, %rdx
    leaq -55(%rbp), %rsi
    movq $STDIN, %rdi
    movl $READ, %eax
    syscall

    # pede para o usuario digitar c2
    movq $promptC2Sz, %rdx
    movq $promptC2, %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    # lê c2
    movq $2, %rdx
    leaq -58(%rbp), %rsi
    movq $STDIN, %rdi
    movl $READ, %eax
    syscall

    # chama a função substituir
    movq -58(%rbp), %rdx
    movq -55(%rbp), %rsi
    leaq -52(%rbp), %rdi
    call substituir

    # imprime a nova string
    movq $resultSz, %rdx
    movq $result, %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    movq $51, %rdx
    leaq -52(%rbp), %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    # epílogo
    movq %rbp, %rsp
    popq %rbp
    movq $0, %rdi
    movl $EXIT, %eax
    syscall

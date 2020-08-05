    .text
    .globl bin2dec
    .type bin2dec, @function
bin2dec:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp  # aloca 16 bytes na pilha

    # obtém o índice do bit mais significativo
    movq %rdi, -16(%rbp)
    call strlen
    movq -16(%rbp), %rdi
    decl %eax
    movl %eax, -4(%rbp)

    movl $0, -8(%rbp)   # resultado

loop:
    # se chegou ao fim da string, sai do loop
    cmpb $0, (%rdi)
    je fim
    cmpb $'\n', (%rdi)
    je fim

    # se o bit atual for 0, pule
    cmpb $'0', (%rdi)
    je nao_soma

    # calcula 2^n
    movq %rdi, -16(%rbp)
    movl -4(%rbp), %esi
    movl $2, %edi
    call pow
    movq -16(%rbp), %rdi

    # soma 2^n
    addl %eax, -8(%rbp)
nao_soma:
    decl -4(%rbp)   # decrementa o índice para o bit atual
    incq %rdi       # aponta para o próximo bit
    jmp loop
fim:
    movl -8(%rbp), %eax # retorna o resultado

    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret

    .text
    .globl strlen
    .type strlen, @function
strlen:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

    movl $0, %eax   # resultado
strlen_loop:
    # enquanto não atingir o fim da string, incrementa o resultado
    cmpb $0, (%rdi)
    je strlen_epilogo
    cmpb $'\n', (%rdi)
    je strlen_epilogo
    incq %rdi
    incl %eax
    jmp strlen_loop

strlen_epilogo:
    movq %rbp, %rsp
    popq %rbp
    ret

    .text
    .globl cleanstr
    .type cleanstr, @function
cleanstr:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

cleanstr_loop:
    # enquanto n (em esi) não for zero, zere o caractere atual
    cmpl $0, %esi
    je cleanstr_epilogo
    movb $0, (%rdi)
    incq %rdi
    decl %esi
    jmp cleanstr_loop

cleanstr_epilogo:
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
    .string "Digite um número binário de até 31 dígitos: "
    .equ promptSz, .-prompt-1
teste:
    .string "100"
result:
    .string "Em decimal: "
    .equ resultSz, .-result-1
newline:
    .string "\n"

    .text
    .globl __start
__start:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp  # aloca 48 bytes para o frame

    # pede para o usuário digitar
    movq $promptSz, %rdx
    movq $prompt, %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    # lê a entrada do usuário
    movq $32, %rdx
    leaq -32(%rbp), %rsi
    movq $STDIN, %rdi
    movl $READ, %eax
    syscall

    # chama a função bin2dec
    leaq -32(%rbp), %rdi
    call bin2dec

    # zera a string
    movl %eax, -36(%rbp)
    movl $32, %esi
    leaq -32(%rbp), %rdi
    call cleanstr

    # chama a função dec2ascii
    leaq -32(%rbp), %rsi
    movl -36(%rbp), %edi
    call dec2ascii

    # imprime o resultado
    movq $resultSz, %rdx
    movq $result, %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    movq $31, %rdx
    leaq -32(%rbp), %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    # pula linha
    movq $1, %rdx
    movq $newline, %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    # epílogo
    movq %rbp, %rsp
    popq %rbp
    movq $0, %rdi
    movl $EXIT, %eax
    syscall

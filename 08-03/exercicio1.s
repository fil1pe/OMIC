    .section .rodata
prompt:
    .string "Digite um número (-1 para terminar): "
scanFmt:
    .string "%d"
resultFmt:
    .string "Soma: %d\nMédia: "
mediaFmt:
    .string "%.2lf\n"
mediaNAFmt:
    .string "n/a\n"

    .text
    .globl main
    .type main, @function
main:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp  # aloca 32 bytes para o frame

    # salva o valor dos registradores r12 e r13
    movq %r12, -12(%rbp)
    movq %r13, -20(%rbp)

    # inicialização das 'variáveis'
    movq $0, %r12   # inicializa a soma
    movq $0, %r13   # inicializa o contador

leitura:
    # pede para o usuário digitar
    movq $prompt, %rdi
    movq $0, %rax
    call printf

    # lê a entrada do usuário
    leaq -4(%rbp), %rsi
    movq $scanFmt, %rdi
    movq $0, %rax
    call scanf

    # sai do loop se o valor lido for -1
    cmpl $-1, -4(%rbp)
    je fim

    # soma o valor lido
    addl -4(%rbp), %r12d

    # incrementa o contador
    incl %r13d

    # sai do loop se a soma atingiu 2048
    cmpl $2048, %r12d
    jge fim

    jmp leitura

fim:
    # imprime a soma
    movl %r12d, %esi
    movq $resultFmt, %rdi
    movq $0, %rax
    call printf

    # imprime que a média não se aplica se o contador for zero
    cmpl $0, %r13d
    je mediaNA

    # divide a soma pelo contador, gerando a média
    cvtsi2sd %r12d, %xmm0
    cvtsi2sd %r13d, %xmm1
    divsd %xmm1, %xmm0

    # imprime a média
    movq $mediaFmt, %rdi
    movq $1, %rax
    call printf

    # termina o programa
    jmp epilogo

mediaNA:
    movq $mediaNAFmt, %rdi
    movq $0, %rax
    call printf

epilogo:
    # volta os registradores r12 e r13 aos valores antigos
    movq -12(%rbp), %r12
    movq -20(%rbp), %r13

    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

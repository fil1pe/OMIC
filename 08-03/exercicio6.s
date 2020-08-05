    .section .rodata
prompt:
    .string "Digite um número: "
intFmt:
    .string "%d"
resultFmt:
    .string "String ASCII: %s\n"

    .text
    .globl main
    .type main, @function
main:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    # pede para o usuário digitar
    movq $prompt, %rdi
    movq $0, %rax
    call printf

    # lê a entrada do usuário
    leaq -4(%rbp), %rsi
    movq $intFmt, %rdi
    movq $0, %rax
    call scanf

    # chama a função dec2ascii
    leaq -16(%rbp), %rsi
    movl -4(%rbp), %edi
    call dec2ascii

    # imprime o resultado
    leaq -16(%rbp), %rsi
    movq $resultFmt, %rdi
    movq $0, %rax
    call printf

    # epílogo
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

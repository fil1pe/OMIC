    .text
    .globl fatorial
    .type fatorial, @function
fatorial:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp  # aloca 16 bytes para o frame

    # se n <= 1, retorna 1
    movq $1, %rax
    cmpq $1, %rdi
    jle fatorial_fim

    # salva n
    movq %rdi, -8(%rbp)

    # chama fatorial(n-1)
    decq %rdi
    call fatorial

    # multiplica fatorial(n-1) por n
    movq -8(%rbp), %rdi
    mulq %rdi
fatorial_fim:
    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret

    .section .rodata
prompt:
    .string "Digite um número: "
scanFmt:
    .string "%d"
printFmt:
    .string "%d! = %d\n"
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

    # lê n
    leaq -4(%rbp), %rsi
    movq $scanFmt, %rdi
    movq $0, %rax
    call scanf

    # chama fatorial
    movl -4(%rbp), %edi
    call fatorial

    # imprime n!
    movq %rax, %rdx
    movq -4(%rbp), %rsi
    movq $printFmt, %rdi
    movq $0, %rax
    call printf

    # epílogo
    movq $0, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

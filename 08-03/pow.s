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

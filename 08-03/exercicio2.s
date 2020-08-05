    .section .rodata
prompt:
    .string "Digite o valor do saque: "
scanFmt:
    .string "%d"
separador:
    .string "=====\n"
resultFmt:
    .string "%d cédula(s) de %d reais\n"

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

    # lê a entrada do usuário
    leaq -4(%rbp), %rsi
	movq $scanFmt, %rdi
	movq $0, %rax
	call scanf

    # imprime o separador
	movq $separador, %rdi
	movq $0, %rax
	call printf

    # abaixo chama a função imprime_cedulas e diminui do montante a qtde. já sacada

    movl -4(%rbp), %edi
    movl $200, %esi
    call imprime_cedulas
    movl %eax, -4(%rbp)

    movl -4(%rbp), %edi
    movl $100, %esi
    call imprime_cedulas
    movl %eax, -4(%rbp)

    movl -4(%rbp), %edi
    movl $50, %esi
    call imprime_cedulas
    movl %eax, -4(%rbp)

    movl -4(%rbp), %edi
    movl $20, %esi
    call imprime_cedulas
    movl %eax, -4(%rbp)

    movl -4(%rbp), %edi
    movl $10, %esi
    call imprime_cedulas
    movl %eax, -4(%rbp)

    movl -4(%rbp), %edi
    movl $5, %esi
    call imprime_cedulas
    movl %eax, -4(%rbp)

    movl -4(%rbp), %edi
    movl $2, %esi
    call imprime_cedulas
    movl %eax, -4(%rbp)

    # epílogo
    movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret


    .text
    .globl imprime_cedulas
    .type imprime_cedulas, @function
imprime_cedulas:
    # prólogo
    pushq %rbp
	movq %rsp, %rbp
    subq $16, %rsp  # aloca 16 bytes para o frame

    # divide o montante pelo valor da cédula
    movl %edi, %eax
    cdq
    divl %esi

    # guarda o resto
    movl %edx, -4(%rbp)

    # imprime o número de notas sendo o quociente acima
    movl %esi, %edx
    movl %eax, %esi
	movq $resultFmt, %rdi
	movq $0, %rax
	call printf

    # retorna o resto
    movl -4(%rbp), %eax

    # epílogo
	movq %rbp, %rsp
	popq %rbp
	ret

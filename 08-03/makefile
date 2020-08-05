gcc_exercicios = 1 2 3 4 6
ld_exercicios = 5
exercicios = $(gcc_exercicios) $(ld_exercicios)

all:
	@for i in $(exercicios); do as exercicio$$i.s --gstabs -o exercicio$$i.o; done
	@for i in $(gcc_exercicios); do gcc exercicio$$i.o -no-pie -o exercicio$$i; done
	@for i in $(ld_exercicios); do ld exercicio$$i.o -e __start -o exercicio$$i; done
	@for i in $(exercicios); do rm exercicio$$i.o; done

clean:
	@for i in $(exercicios); do rm exercicio$$i; done
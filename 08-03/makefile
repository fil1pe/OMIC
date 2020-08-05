gcc_exercicios = 1 2 4 6
exercicios = $(gcc_exercicios) 3 5 7

all:
	@as pow.s --gstabs -o pow.o

	@for i in $(exercicios); do as exercicio$$i.s --gstabs -o exercicio$$i.o; done

	@for i in $(gcc_exercicios); do gcc exercicio$$i.o -no-pie -o exercicio$$i; done
	@gcc exercicio3.o pow.o -no-pie -o exercicio3

	@ld exercicio5.o -e __start -o exercicio5
	@ld pow.o exercicio7.o -e __start -o exercicio7

	@rm *.o

clean:
	@for i in $(exercicios); do rm exercicio$$i; done
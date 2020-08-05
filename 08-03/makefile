exercicios = 1 2 3 4 5 6 7

all:
	@as pow.s --gstabs -o pow.o
	@as dec2ascii.s --gstabs -o dec2ascii.o

	@for i in $(exercicios); do as exercicio$$i.s --gstabs -o exercicio$$i.o; done

	@for i in 1 2 4; do gcc exercicio$$i.o -no-pie -o exercicio$$i; done
	@gcc exercicio3.o pow.o -no-pie -o exercicio3
	@gcc exercicio6.o dec2ascii.o -no-pie -o exercicio6

	@ld exercicio5.o -e __start -o exercicio5
	@ld pow.o dec2ascii.o exercicio7.o -e __start -o exercicio7

	@rm *.o

clean:
	@for i in $(exercicios); do rm exercicio$$i; done
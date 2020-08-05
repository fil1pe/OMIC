all:
	@as exercicio2.s --gstabs -o exercicio2.o
	@gcc exercicio2.o -no-pie -o exercicio2
	@as exercicio4.s --gstabs -o exercicio4.o
	@ld exercicio4.o -e __start -o exercicio4
clear:
	@rm exercicio2.o exercicio2 exercicio4.o exercicio4

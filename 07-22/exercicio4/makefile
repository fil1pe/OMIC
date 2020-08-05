all:
	@as fibonacci.s --gstabs -o fibonacci.o
	@as main.s --gstabs -o main.o
	@gcc main.o fibonacci.o -no-pie -o main
	@echo "Para executar: make run"
run:
	@./main
clear:
	@rm fibonacci.o main.o main

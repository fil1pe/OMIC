all:
	@as to_upper.s --gstabs -o to_upper.o
	@as main.s --gstabs -o main.o
	@gcc main.o to_upper.o -no-pie -o main
	@echo "Para executar: make run"
run:
	@./main
clear:
	@rm to_upper.o main.o main

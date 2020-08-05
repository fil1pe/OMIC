all:
	@as to_lower.s --gstabs -o to_lower.o
	@as main.s --gstabs -o main.o
	@gcc main.o to_lower.o -no-pie -o main
	@echo "Para executar: make run"
run:
	@./main
clear:
	@rm to_lower.o main.o main

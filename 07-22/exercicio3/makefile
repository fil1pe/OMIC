all:
	@as sumInts.s --gstabs -o sumInts.o
	@as main.s --gstabs -o main.o
	@gcc main.o sumInts.o -no-pie -o main
	@echo "Para executar: make run"
run:
	@./main
clear:
	@rm sumInts.o main.o main

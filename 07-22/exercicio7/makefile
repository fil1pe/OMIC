all:
	@as sumInts.s -o sumInts.o
	@gcc sumInts_main.c sumInts.o -no-pie -o sumInts_main
	@echo "Para executar: ./sumInts_main"
	@as fibonacci.s -o fibonacci.o
	@gcc fibonacci_main.c fibonacci.o -no-pie -o fibonacci_main
	@echo "Para executar: ./fibonacci_main"
	@as to_upper.s -o to_upper.o
	@gcc to_upper_main.c to_upper.o -no-pie -o to_upper_main
	@echo "Para executar: ./to_upper_main"
	@as to_lower.s -o to_lower.o
	@gcc to_lower_main.c to_lower.o -no-pie -o to_lower_main
	@echo "Para executar: ./to_lower_main"
clear:
	@rm sumInts.o sumInts_main
	@rm fibonacci.o fibonacci_main
	@rm to_upper.o to_upper_main
	@rm to_lower.o to_lower_main

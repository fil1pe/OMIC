#include <stdio.h>

extern int sumInts(int a, int b, long *sum);

int main() {
	int a, b;
	long sum;
	printf("Digite dois numeros para somar: ");
	scanf("%i %i", &a, &b);
	if (!sumInts(a, b, &sum))
		printf("Soma: %li\n", sum);
	else
		printf("Overflow!\n");

	return 0;
}

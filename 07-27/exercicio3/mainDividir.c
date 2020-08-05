#include <stdio.h>

extern int dividir(int dividendo, int divisor, int *resto);

int main() {
	int dividendo, divisor, resultado, resto;
	scanf("%i %i", &dividendo, &divisor);
	resultado = dividir(dividendo, divisor, &resto);
	printf("%d/%d=%d resto %d\n", dividendo, divisor, resultado, resto);

	return 0;
}

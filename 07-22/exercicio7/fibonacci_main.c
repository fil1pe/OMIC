#include <stdio.h>

extern long fibonacci(long n);

int main() {
	long n;

	while (1) {
		scanf("%li", &n);
		if (n < 0) break;
		printf("%li\n", fibonacci(n));
	}

	return 0;
}

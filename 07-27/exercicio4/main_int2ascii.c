#include <stdio.h>

extern int int2ascii(int n, char *str);

int main() {
	int n;
	char str[12];

	scanf("%d", &n);

	int2ascii(n, str);

	printf("%s\n", str);

	return 0;
}

#include <stdio.h>

extern int to_lower(char *str);

int main() {
	char str[1000];

	scanf("%s", str);

	to_lower(str);

	printf("%s\n", str);

	return 0;
}

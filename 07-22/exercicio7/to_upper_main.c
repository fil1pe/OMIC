#include <stdio.h>

extern int to_upper(char *str);

int main() {
	char str[1000];

	scanf("%s", str);

	to_upper(str);

	printf("%s\n", str);

	return 0;
}

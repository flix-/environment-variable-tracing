#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

char *str[1024];

int
main()
{
    char *strl[1024];
    strl[100] = getenv("gude");

    memcpy(str, strl, 1024);

    char *t1 = str[100];
    char *ut1 = str[99];

    return 0;
}


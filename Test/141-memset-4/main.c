#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *str[1024];
    str[2] = getenv("gude");

    char *t = str[2];

    memset(str, 0, 1024);

    char *not_tainted = str[2];

    return 0;
}


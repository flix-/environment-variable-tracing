#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *tainted = getenv("hi");
    char dst;

    memmove(&dst, tainted, 1);

    char t = dst;

    return 0;
}


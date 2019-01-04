#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *tainted = getenv("hi");
    char dst;

    memcpy(&dst, tainted, 1);

    return 0;
}


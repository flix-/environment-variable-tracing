#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *tainted = getenv("hi");
    memset(tainted, 0, 3);

    char *not_tainted = tainted;

    return 0;
}


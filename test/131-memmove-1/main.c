#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *tainted = getenv("hi");
    char t[3];

    memmove(t, tainted, 3);

    char *also_tainted = t;

    return 0;
}


#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *tainted = getenv("hi");
    char *not_tainted1 = "hi";

    memcpy(tainted, not_tainted1, 3);

    char *not_tainted2 = tainted;

    return 0;
}


#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *no_taint = "gude";

    int ret;
    if (no_taint != NULL) {
        int a = 42;
        ret = a;
    }

    return ret;
}


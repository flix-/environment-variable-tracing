#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *taint = getenv("gude");

    int ret;
    if (taint != NULL) {
        int a = 42;
        ret = a;
    }

    return ret;
}


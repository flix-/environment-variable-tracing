#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *taint = getenv("gude");

    return 0;
}


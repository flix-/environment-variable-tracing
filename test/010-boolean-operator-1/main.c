#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int no_taint = foo() || bar();

    return 0;
}


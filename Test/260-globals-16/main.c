#include <stdarg.h>

extern char *getenv(const char *name);

char *t;

void
foo() {
    char *t1 = t;
}

int
main()
{
    t = getenv("gude");

    foo();

    return 0;
}


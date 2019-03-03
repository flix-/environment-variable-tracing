#include <stdarg.h>

extern char *getenv(const char *name);

char *t;

void
foo() {
    t = getenv("gude");
}

int
main()
{
    char *ut1 = t;

    foo();

    char *t1 = t;

    return 0;
}


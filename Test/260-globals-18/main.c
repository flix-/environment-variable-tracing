#include <stdarg.h>

extern char *getenv(const char *name);

char *gt;

void
foo() {
    char *t1 = gt;

    gt = "untaint";

    char *ut1 = gt;
}

int
main()
{
    gt = getenv("gude");

    char *t1 = gt;

    foo();

    char *ut1 = gt;

    return 0;
}


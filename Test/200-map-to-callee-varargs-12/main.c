#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

void
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    int t1 = va_arg(ap, int);

    int t2 = t1;

    va_end(ap);
}

int
main()
{
    int t = getenv("gude") != NULL ? 1 : 0;

    foo(1, t + 1);

    return 0;
}


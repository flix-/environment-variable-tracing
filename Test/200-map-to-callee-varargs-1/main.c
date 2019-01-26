#include <stdarg.h>

extern char *getenv(const char *name);

void
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    char *x = va_arg(ap, char *);

    char *t1 = x;

    va_end(ap);
}

int
main()
{
    char *t = getenv("gude");

    foo(1, t);

    return 0;
}


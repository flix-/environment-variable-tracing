#include <stdarg.h>

extern char *getenv(const char *name);

void
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    char *x = va_arg(ap, char *);
    char *y = va_arg(ap, char *);
    char *z = va_arg(ap, char *);

    char *t1 = x;
    char *ut1 = y;
    char *ut2 = z;

    va_end(ap);
}

int
main()
{
    char *t = getenv("gude");

    foo(1, t);

    return 0;
}


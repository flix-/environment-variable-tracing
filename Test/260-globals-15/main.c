#include <stdarg.h>

extern char *getenv(const char *name);

char *str[1024];
char *gt;

char *
foo(int n, ...) {
    va_list ap;
    va_start(ap, n);

    char *t1 = va_arg(ap, char *);
    char *ut1 = va_arg(ap, char *);
    char *t2 = va_arg(ap, char *);

    va_end(ap);

    gt = getenv("gude");

    return gt;
}

int
main()
{
    str[10] = getenv("gude");

    char *ret = foo(2, str[10], str[9], getenv("gude"));

    char *t1 = ret;

    return 0;
}


#include <stdarg.h>

extern char *getenv(const char *name);

char *str[1024];

int
foo(int n, ...) {
    va_list ap;
    va_start(ap, n);

    char *t1 = va_arg(ap, char *);
    char *ut1 = va_arg(ap, char *);
    char *t2 = va_arg(ap, char *);

    va_end(ap);

    return 0;
}

int
main()
{
    str[10] = getenv("gude");

    int rc = foo(2, str[10], str[9], getenv("gude"));

    return rc;
}


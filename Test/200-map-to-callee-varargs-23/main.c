#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s1 {
    int a;
    char *t;
};

int
foo(int n, ...)
{
    va_list args1;
    va_start(args1, n);

    va_list args2;
    va_start(args2, n);

    va_end(args1);
    va_end(args2);

    struct s1 s2n = va_arg(args1, struct s1);
    struct s1 s2nn = va_arg(args2, struct s1);

    return 0;
}

int
main()
{
    struct s1 s;
    s.t = getenv("gude");

    foo(1, s);

    return 0;
}


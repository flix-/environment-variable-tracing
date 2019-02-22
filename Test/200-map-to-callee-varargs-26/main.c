#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct va {
    va_list a1;
    va_list a2;
};

struct s1 {
    int a;
    char *t;
};

int
foo(int n, ...)
{
    struct va va_lists;

    va_start(va_lists.a1, n);

    struct s1 t1 = va_arg(va_lists.a1, struct s1);

    struct s1 nt1 = va_arg(va_lists.a2, struct s1);

    va_end(va_lists.a1);

    return 0;
}

int
main()
{
    struct s1 s;
    s.t = getenv("gude");

    foo(1, s, getenv("gude"));

    return 0;
}


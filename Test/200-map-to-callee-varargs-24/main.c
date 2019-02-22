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

    struct s1 s1 = va_arg(args1, struct s1);
    va_end(args1);
    char *nt = va_arg(args1, char *);

    struct s1 s11 = va_arg(args2, struct s1);
    char *t1 = va_arg(args2, char *);

    va_end(args2);


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


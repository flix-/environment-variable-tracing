#include <stdarg.h>

extern char *getenv(const char *name);

struct s2 {
    char *t1;
    char *ut1;
};

struct s1 {
    int a;
    int b;
    struct s2 s2;
};

void
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    struct s1 s1;

    s1.s2.t1 = va_arg(ap, char *);
    s1.s2.ut1 = va_arg(ap, char *);
    char *z = va_arg(ap, char *);

    char *t1 = s1.s2.t1;
    char *ut1 = s1.s2.ut1;
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


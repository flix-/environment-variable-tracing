#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s2 {
    char *t1;
    char *t2;
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
    va_list ap1;
    va_start(ap1, n);
    va_list ap2;
    va_start(ap2, n);

    struct s2 s2 = va_arg(ap1, struct s2);

    char *t1 = s2.t1;
    char *t2 = s2.t2;
    char *ut1 = s2.ut1;

    va_end(ap1);

    struct s2 s21 = va_arg(ap2, struct s2);

    char *t12 = s21.t1;
    char *t22 = s21.t2;
    char *ut12 = s21.ut1;

    va_end(ap2);
}

int
main()
{
    struct s2 s2;
    s2.t1 = getenv("gude");
    s2.t2 = s2.t1;

    foo(1, s2);

    return 0;
}


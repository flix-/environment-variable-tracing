#include <stdarg.h>

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
    va_list ap;
    va_start(ap, n);

    struct s1 s1;

    s1.s2.t1 = va_arg(ap, char *);
    s1.s2.t2 = va_arg(ap, char *);
    s1.s2.ut1 = va_arg(ap, char *);

    char *t1 = s1.s2.t1;
    char *ut1 = s1.s2.t2;
    char *ut2 = s1.s2.ut1;

    va_end(ap);
}

int
main()
{
    char *t1 = getenv("gude");
    char *t2 = t1;

    foo(1, t1, t2, "i am not tainted");

    return 0;
}


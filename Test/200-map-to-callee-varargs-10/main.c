#include <stdarg.h>

extern char *getenv(const char *name);

struct s1 {
    int a;
    int b;
    char *t1;
};

void
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    struct s1 s1 = va_arg(ap, struct s1);

    char *t1 = s1.t1;
    int ut1 = s1.a;
    int ut2 = s1.b;

    va_end(ap);
}

int
main()
{
    struct s1 s1;
    s1.t1 = getenv("gude");

    foo(1, s1);

    return 0;
}


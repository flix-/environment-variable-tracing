#include <stdarg.h>

extern char *getenv(const char *name);

struct s3 {
    int *a;
    int *b;
    char *t1;
};

struct s2 {
    char *t1;
    struct s3 s3;
};

struct s1 {
    int a;
    int b;
    struct s2* s2;
};

void
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    struct s2 *s2 = va_arg(ap, struct s2 *);

    char *also_tainted = s2->s3.t1;
    char *nt1 = s2->t1;
    int *nt2 = s2->s3.a;
    int *nt3 = s2->s3.b;

    va_end(ap);
}

int
main()
{
    struct s2 s2;
    s2.s3.t1 = getenv("gude");
    struct s1 s1;
    s1.s2 = &s2;

    foo(1, s1.s2);

    return 0;
}


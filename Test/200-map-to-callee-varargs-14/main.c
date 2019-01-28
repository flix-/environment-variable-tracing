#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

union u1 {
    char *t1;
    int a;
};

struct s2 {
    double i;
    union u1 u;
};

struct s1 {
    int a;
    int b;
    char *t1;
    struct s2 s2;
};

struct s2 *
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    int ut1 = va_arg(ap, int);
    struct s1 s1 = va_arg(ap, struct s1);
    struct s1 *s1ptr = va_arg(ap, struct s1 *);
    struct s2 s2 = va_arg(ap, struct s2);
    struct s2 *s2ptr = va_arg(ap, struct s2 *);
    char *ut2 = va_arg(ap, char *);

    va_end(ap);

    char *t1 = s1.s2.u.t1;
    int ut3 = s1.s2.u.a;

    char *t2 = s1ptr->s2.u.t1;
    int ut4 = s1ptr->s2.u.a;

    char *t3 = s2.u.t1;
    int ut5 = s2.u.a;

    char *t4 = s2ptr->u.t1;
    int ut6 = s2ptr->u.a;

    return s2ptr;
}

int
main()
{
    struct s1 s1;
    s1.s2.u.t1 = getenv("gude");

    struct s2 *s2 = foo(8, 4711, s1, &s1, s1.s2, &s1.s2, "not tainted");

    char *t1 = s2->u.t1;
    int ut1 = s2->u.a;

    int rc = t1 != NULL;

    return rc;
}


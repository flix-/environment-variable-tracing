#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s3 {
    char *t1;
    char *ut1;
};

struct s2 {
    struct s3 *s3;
    double i;
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
    struct s3 s3 = va_arg(ap, struct s3);
    struct s3 *s3ptr = va_arg(ap, struct s3 *);
    char *ut2 = va_arg(ap, char *);

    va_end(ap);

    char *t1 = s1.s2.s3->t1;
    char *ut3 = s1.t1;
    char *ut4 = s1.s2.s3->ut1;

    char *t2 = s1ptr->s2.s3->t1;
    char *ut5 = s1ptr->t1;
    char *ut6 = s1ptr->s2.s3->ut1;

    char *t3 = s2.s3->t1;
    char *ut7 = s2.s3->ut1;

    char *t4 = s2ptr->s3->t1;
    char *ut8 = s2ptr->s3->ut1;

    char *t5 = s3.t1;
    char *ut9 = s3.ut1;

    char *t6 = s3ptr->t1;
    char *ut10 = s3ptr->ut1;

    return s2ptr;
}

int
main()
{
    struct s3 s3;
    s3.t1 = getenv("gude");

    struct s1 s1;
    s1.s2.s3 = &s3;

    struct s2 *s2 = foo(8, 4711, s1, &s1, s1.s2, &s1.s2, s3, &s3, "not tainted");

    char *t1 = s2->s3->t1;
    char *ut1 = s2->s3->ut1;

    int rc = t1 != NULL;

    return rc;
}


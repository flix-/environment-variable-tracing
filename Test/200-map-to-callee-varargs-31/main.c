#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s2 {
    va_list vas;
};

struct s1 {
    struct s2 s;
};

int
foo(va_list args)
{
    if (getenv("gude") != NULL) {
        int t = va_arg(args, int);
    }

    char *t2 = va_arg(args, char *);

    char *nt = va_arg(args, char *);

    int nt2 = 1;

    return -1;
}

int
user(struct s2 *s2, va_list args, ...)
{
    char *nt1 = va_arg(s2->vas, char *);
    char *t2 = va_arg(s2->vas, char *);
    char *nt2 = va_arg(s2->vas, char *);
    char *nt3 = va_arg(s2->vas, char *);

    char *t12 = va_arg(args, char *);
    char *nt12 = va_arg(args, char *);
    char *t22 = va_arg(args, char *);
    char *nt22 = va_arg(args, char *);

    va_list ap1;
    va_start(ap1, args);

    int a = va_arg(ap1, int);
    char *t123 = va_arg(ap1, char *);

    va_end(ap1);

    va_list ap2;
    va_start(ap2, args);

    foo(ap2);

    va_end(ap2);

    return 0;
}

int
forwarder(int n, ...)
{
    struct s1 s;

    va_start(s.s.vas, n);
    
    char *t1 = va_arg(s.s.vas, char *);

    int rc = user(&s.s, s.s.vas, 4711, getenv("gude"));

    va_end(s.s.vas);

    return rc;
}

int
main()
{
    char *not_tainted = "hello world";
    char *tainted = getenv("gude");

    int rc = forwarder(6, tainted, not_tainted, tainted, not_tainted, not_tainted);

    return rc;
}


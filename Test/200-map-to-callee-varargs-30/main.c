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

    va_list ap;
    va_start(ap, args);

    int a = va_arg(ap, int);
    char *t123 = va_arg(ap, char *);

    va_end(ap);

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


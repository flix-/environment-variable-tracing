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
user(struct s2 s2)
{
    char *t1 = va_arg(s2.vas, char *);
    char *nt1 = va_arg(s2.vas, char *);
    char *t2 = va_arg(s2.vas, char *);
    char *nt2 = va_arg(s2.vas, char *);
    char *nt3 = va_arg(s2.vas, char *);

    return 0;
}

int
forwarder(int n, ...)
{
    struct s1 s;

    va_start(s.s.vas, n);

    int rc = user(s.s);

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


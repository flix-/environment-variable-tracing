#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

int
user(char *t, va_list args, int n, char *tt, char *ntt)
{
    char *ttt = t;
    char *tttt = tt;
    int n1 = n;
    char *nttt = ntt;

    char *t1 = va_arg(args, char *);

    if (getenv("gude") != NULL) {
        char *t2 = va_arg(args, char *);
    }

    char *t3 = va_arg(args, char *);
    char *t4 = va_arg(args, char *);

    char *nt = va_arg(args, char *);

    return 0;
}

int
forwarder(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    int rc = user(getenv("gude"), ap, 4711, getenv("gude"), "hello world");

    va_end(ap);

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


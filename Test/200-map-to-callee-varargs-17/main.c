#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

int
user(va_list args)
{
    char *t1 = va_arg(args, char *);
    char *nt1 = va_arg(args, char *);
    char *t2 = va_arg(args, char *);
    char *nt2 = va_arg(args, char *);
    char *nt3 = va_arg(args, char *);

    return 0;
}

int
forwarder(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    int rc = user(ap);

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


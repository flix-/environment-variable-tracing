#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

static int
fake_dopr(va_list args)
{
    char *t1 = va_arg(args, char *);
    char *nt1 = va_arg(args, char *);
    char *t2 = va_arg(args, char *);
    char *nt2 = va_arg(args, char *);
    char *nt3 = va_arg(args, char *);

    return -1;
}

int
fake_BIO_vprintf(int n, va_list args)
{
    return fake_dopr(args);
}

int
fake_BIO_printf(int n, ...)
{
    va_list args;
    va_start(args, n);

    int rc = fake_BIO_vprintf(n, args);

    va_end(args);

    return rc;
}

int
main()
{
    char *not_tainted = "hello world";
    char *tainted = getenv("gude");

    int rc = fake_BIO_printf(6, tainted, not_tainted, tainted, not_tainted, not_tainted);

    return rc;
}


#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

int
foo(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    char *v0 = va_arg(ap, char *);

    if (v0 != NULL) {
        char *v1 = va_arg(ap, char *);
    }
    
    char *nt = "gude";

    char *v2 = va_arg(ap, char *);
    char *v3 = va_arg(ap, char *);
    
    char *no = va_arg(ap, char *);

    int nt_1 = 1;

    va_end(ap);

    int nt_2 = 1;

    return 0;
}

int
main()
{
    char *not_tainted = "hello world";
    char *tainted = getenv("gude");

    int rc = foo(6, tainted, not_tainted, tainted, not_tainted, not_tainted);

    return rc;
}


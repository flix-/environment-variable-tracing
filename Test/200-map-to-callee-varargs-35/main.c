#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s2 {
    char *t1;
    char *ut1;
    int a;
};

struct s1 {
    int a;
    int b;
    va_list vas;
};

void
foo(va_list args) {
    struct s2 s;

    s.a = va_arg(args, int);
    s.ut1 = va_arg(args, char *);
    s.t1 = va_arg(args, char *);
}

int
forwarder(int n, ...)
{
    struct s1 s;

    va_start(s.vas, n);
    
    foo(s.vas);

    va_end(s.vas);

    return 0;
}

int
main()
{
    int rc = forwarder(3, 1, "hello", getenv("gude"));

    return rc;
}


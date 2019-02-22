#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s2 {
    va_list vas;
};

struct s1 {
    struct s2 s;
};

struct s5 {
    char *t1;
    char *ut1;
};

struct s4 {
    int a;
    int b;
    char *t1;
    char *ut2;
    struct s5 *s5;
};

int
forwarder(int n, ...)
{
    struct s1 s;

    va_start(s.s.vas, n);
    
    struct s4 ss;
    ss.s5 = va_arg(s.s.vas, struct s5*);

    char *t1 = ss.s5->t1;

    va_end(s.s.vas);

    return 0;
}

int
main()
{
    struct s4 s;
    struct s5 ss;
    s.s5 = &ss;

    s.s5->t1 = getenv("gude");

    int rc = forwarder(1, &s.s5);

    return rc;
}


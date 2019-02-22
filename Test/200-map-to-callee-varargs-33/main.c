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

void
foo(struct s1 s) {
    struct s4 ss;
    ss.s5 = va_arg(s.s.vas, struct s5*);

    char *nt = ss.s5->t1;
}

int
forwarder(int n, ...)
{
    struct s1 s;

    va_start(s.s.vas, n);
    va_end(s.s.vas);

    foo(s);

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


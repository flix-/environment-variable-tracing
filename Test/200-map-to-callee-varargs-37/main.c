#include <stdarg.h>
#include <stdlib.h>

extern char *getenv(const char *name);

struct s5 {
    char *t1;
    char *ut1;
};

struct s2 {
    int a;
    int b;
    char *t;
    struct s5 s5;
    va_list vas;
    char *f;
};

struct s1 {
    int a;
    int b;
    char *t;
    struct s2 s;
};

struct s4 {
    int a;
    int b;
    char *t1;
    char *ut2;
    struct s5 *s5;
};

void
foo(struct s2 s) {
    struct s4 ss;
    ss.s5 = va_arg(s.vas, struct s5*);

    char *t = ss.s5->t1;
}

int
forwarder(int n, ...)
{
    struct s1 s;

    va_start(s.s.vas, n);
    
    foo(s.s);

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


#include <stdlib.h>

extern char *getenv(const char *name);

struct s3 {
    int *a;
    int *b;
    char *t1;
};

struct s2 {
    char *t1;
    struct s3 s3[2][2];
};

struct s1 {
    int a;
    int b;
    struct s2* s2;
};

void
foo(struct s2 *s2)
{
    char *t1 = s2->s3[0][1].t1;
    int *ut1 = s2->s3[0][0].a;
    char *ut2 = s2->s3[0][0].t1;
}

int
main()
{
    struct s1 s1;
    struct s2 s2;

    s2.s3[0][1].t1 = getenv("gude");
    s1.s2 = &s2;

    foo(s1.s2);

    return 0;
}


#include <stdlib.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s3 {
    int i1;
    int i2;
    char *t3;
};

struct s2 {
    int i1;
    char *t2;
    struct s3 *s3;
};

struct s1 {
    char *t1;
    struct s2 s2;
};

int
main()
{
    struct s1 s1;
    struct s3 s3;
    s3.t3 = getenv("gude");

    s1.s2.s3 = &s3;
    char *t1 = s1.s2.s3->t3;

    struct s3 s32;
    s1.s2.s3 = &s32;
    char *ut1 = s1.s2.s3->t3;

    return 0;
}


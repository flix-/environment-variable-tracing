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
    struct s3 s3;
};

struct s1 {
    char *t1;
    struct s2 s2;
};

int
main()
{
    struct s1 s1;
    s1.s2.s3.t3 = getenv("gude");
    s1.s2.t2 = s1.s2.s3.t3;

    struct s3 s31 = s1.s2.s3;
    char *t1 = s31.t3;

    struct s3 s32;
    s31 = s32;

    char *nt1 = s31.t3;

    struct s2 *s21 = &s1.s2;
    char *t2 = s21->s3.t3;
    char *t3 = s21->t2;

    int nt2 = s21->i1;

    struct s2 **s22 = &s21;
    char *t4 = (*s22)->s3.t3;
    char *t5 = (*s22)->t2;

    *s22 = NULL;
    char *nt3 = (*s22)->s3.t3;
    char *nt4 = (*s22)->t2;

    return 0;
}


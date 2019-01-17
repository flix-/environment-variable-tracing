#include <string.h>

extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s3 {
    int i1;
    int i2;
    int i3;
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

struct s6 {
    struct s2 s2;
};

struct s5 {
    struct s6 s6;
};

struct s4 {
    int a;
    int b;
    int c;
    int d;
    int e;
    struct s5 s5;
};


int
main()
{
    struct s1 s1;
    s1.s2.s3.t3 = getenv("gude");
    s1.s2.t2 = getenv("gude");

    char *t1 = s1.s2.s3.t3;
    char *t2 = s1.s2.t2;

    memcpy(&s1.s2.s3.t3, &s1.t1, 1024);

    char *ut1 = s1.s2.s3.t3;
    char *t3 = s1.s2.t2;

    return 0;
}


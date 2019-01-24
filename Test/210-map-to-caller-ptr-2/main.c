extern char* getenv(const char *name);

struct s2 {
    char *t1;
    char *nt1;
};

struct s5 {
    struct s2 s2;
};

struct s4 {
    struct s5 s5;
};

struct s3 {
    char *t1;
    struct s4 s4;
};

struct s1 {
    char *t1;
    struct s2 *s2;
};

struct s2 *
foo()
{
    struct s3 s3;
    s3.t1 = getenv("gude");
    s3.s4.s5.s2.t1 = getenv("gude");

    return &s3.s4.s5.s2;
}

int
main()
{
    struct s1 s1;
    s1.s2 = foo();

    char *t1 = s1.s2->t1;
    char *nt1 = s1.s2->nt1;

    return 0;
}


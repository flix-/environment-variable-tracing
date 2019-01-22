extern char *getenv(const char *name);

struct s3 {
    int *a;
    int *b;
    char *t1;
};

struct s2 {
    char *t1;
    struct s3 s3;
};

struct s1 {
    int a;
    int b;
    struct s2* s2;
};

void
foo(struct s3 s3)
{
    char *also_tainted = s3.t1;
}

int
main()
{
    struct s2 s2;
    s2.s3.t1 = getenv("gude");
    struct s1 s1;
    s1.s2 = &s2;

    foo(s1.s2->s3);

    return 0;
}


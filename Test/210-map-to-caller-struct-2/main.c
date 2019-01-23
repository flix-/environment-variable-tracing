extern char* getenv(const char *name);

struct s2 {
    char *t1;
    char *t2;
};

struct s1 {
    int a;
    int b;
    char *t1;
    struct s2 s2;
};

struct s2
foo(struct s1 s1)
{
    s1.s2.t2 = getenv("gude");
    return s1.s2;
}

int
main()
{
    struct s1 s1;
    s1.s2.t1 = getenv("gude");

    struct s2 s2 = foo(s1);

    char *t1 = s2.t1;
    char *t2 = s2.t2;

    return 0;
}


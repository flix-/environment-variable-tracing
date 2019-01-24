extern char* getenv(const char *name);

struct s2 {
    char *t2;
    char *t3;
};

struct s1 {
    char *t1;
    struct s2 s2;
};

struct s2
foo()
{
    struct s1 s1;
    s1.s2.t2 = getenv("gude");

    return s1.s2;
}

int
main()
{
    struct s1 s1;
    s1.s2 = foo();

    char *t1 = s1.s2.t2;

    return 0;
}


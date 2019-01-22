extern char *getenv(const char *name);

struct s2 {
    int a;
    int b;
    char *t1;
};

struct s1 {
    int a;
    int b;
    struct s2 s2;
};

void
foo(struct s2 fs)
{
    char *t2 = fs.t1;
    int ut1 = fs.a;
    int ut2 = fs.b;
}

int
main()
{
    struct s1 s1;
    s1.s2.t1 = getenv("gude");
    foo(s1.s2);

    return 0;
}


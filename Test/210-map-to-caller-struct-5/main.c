extern char* getenv(const char *name);

struct s1 {
    int a;
    char *tainted;
};

struct s1
foo(struct s1 s)
{
    return s;
}

int
main()
{
    struct s1 s11;
    s11.tainted = getenv("gude");

    struct s1 s12;
    s12 = foo(s11);
    s12 = foo(s11);
    s12 = foo(s11);
    s12 = foo(s11);

    int not_tainted = s12.a;
    char *tainted = s12.tainted;

    return 0;
}


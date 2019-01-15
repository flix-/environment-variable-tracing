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
    struct s1 s;
    s.tainted = getenv("gude");

    struct s1 s2;
    s2 = foo(s);
    char *tainted = s2.tainted;

    return 0;
}


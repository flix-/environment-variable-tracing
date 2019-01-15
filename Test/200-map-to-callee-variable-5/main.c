extern char *getenv(const char *name);

struct s1 {
    int a;
    char *tainted;
    char *b;
};

void
foo(char *tainted_foo)
{
    char *also_tainted_foo = tainted_foo;
}

int
main()
{
    struct s1 s;
    s.tainted = getenv("gude");
    foo(s.tainted);

    return 0;
}


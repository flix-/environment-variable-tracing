extern char *getenv(const char *name);

struct s1 {
    int a;
    int b;
    char *tainted1;
    char *tainted2;
};

void
foo(struct s1 fs, int a)
{
    char *also_tainted = fs.tainted1;
    fs.tainted1 = also_tainted;
    fs.tainted1 = "nope";
    char *not_tainted = fs.tainted1;
}

int
main()
{
    struct s1 ms;
    ms.tainted1 = getenv("gude");
    foo(ms, 42);

    return 0;
}


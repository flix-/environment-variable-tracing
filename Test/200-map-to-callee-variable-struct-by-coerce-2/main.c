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
    char *tainted = fs.tainted1;
    char *not_tainted = fs.tainted2;
    fs.tainted1 = "noe";
    char *not_tainted2 = fs.tainted1;
}

int
main()
{
    struct s1 ms;
    ms.tainted1 = getenv("gude");
    foo(ms, 42);

    return 0;
}


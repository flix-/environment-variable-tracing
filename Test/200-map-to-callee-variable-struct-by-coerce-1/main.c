extern char *getenv(const char *name);

struct s1 {
    int a;
    int b;
    char *tainted1;
};

void
foo(struct s1 fs, int a)
{
    char *tainted = fs.tainted1;
    int not_tainted1 = fs.a;
    int not_tainted2 = fs.b;
    int not_tainted3 = a;
}

int
main()
{
    struct s1 ms;
    ms.tainted1 = getenv("gude");
    foo(ms, 42);

    return 0;
}


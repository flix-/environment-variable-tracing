extern char *getenv(const char *name);

struct s1 {
    int a;
    int b;
    char *tainted1;
    char *tainted2;
};

void
foo(char *t)
{
    char *also_tainted = t;
}

int
main()
{
    struct s1 ms;
    ms.tainted1 = getenv("gude");
    foo(ms.tainted1);

    return 0;
}


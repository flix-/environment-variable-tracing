extern char *getenv(const char *name);

struct s1 {
    float a;
    float b;
    char *t1;
};

void
foo(struct s1 s1)
{
    char *t1 = s1.t1;
}

int
main()
{
    struct s1 s1;
    s1.t1 = getenv("gude");
    foo(s1);

    return 0;
}


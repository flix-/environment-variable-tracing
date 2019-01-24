extern char* getenv(const char *name);

struct s1 {
    char *t1;
    char *nt1;
};

struct s1 *
foo(struct s1 *s1)
{
    s1->t1 = getenv("gude");

    return s1;
}

int
main()
{
    struct s1 *s1;

    s1 = foo(s1);

    char *t1 = s1->t1;
    char *nt1 = s1->nt1;

    return 0;
}


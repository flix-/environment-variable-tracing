extern char *getenv(const char *name);

char *
foo(char *s)
{
    return s;
}

int
main()
{
    char *s = getenv("gude");
    char *t = foo(s);

    char *t1 = t;

    return 0;
}


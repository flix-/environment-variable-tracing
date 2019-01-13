extern char *getenv(const char *name);

void
foo(char *s[])
{
    char *tainted = s[0];
    char *not_tainted = s[1];
}

int
main()
{
    char *s[42];
    s[0] = getenv("hi");

    foo(s);

    return 0;
}


extern char *getenv(const char *name);

void
foo(char *s[])
{
    char *t1 = s[1];
    char *nt1 = s[2];
}

int
main()
{
    char *s[42];
    s[1] = getenv("hi");

    foo(s);

    return 0;
}


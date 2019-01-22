extern char *getenv(const char *name);

void
foo(char *s[2][2])
{
    char *nt1 = s[0][0];
    char *t1 = s[0][1];
    char *nt2 = s[1][0];
    char *nt3 = s[1][1];
}

int
main()
{
    char *s[2][2];
    s[0][1] = getenv("hi");

    foo(s);

    return 0;
}


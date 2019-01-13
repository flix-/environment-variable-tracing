extern char *getenv(const char *name);

union a {
    char *tainted;
    char *foo;
};

void
foo(char *tainted)
{
    char *tainted2 = tainted;
}

int
main()
{
    union a f;
    f.tainted = getenv("hi");

    foo(f.foo);

    return 0;
}


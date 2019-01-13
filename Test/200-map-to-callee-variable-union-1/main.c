extern char *getenv(const char *name);

union a {
    char *tainted;
};

void
foo(union a f)
{
    char *tainted = f.tainted;
}

int
main()
{
    union a f;
    f.tainted = getenv("hi");

    foo(f);

    return 0;
}


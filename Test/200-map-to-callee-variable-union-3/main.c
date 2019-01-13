extern char *getenv(const char *name);

union b {
    char *tainted;
};

union a {
    char *foo;
    union b ub;
};

void
foo(union a ua)
{
    char *tainted = ua.foo;
}

int
main()
{
    union a f;
    f.ub.tainted = getenv("hi");

    foo(f);

    return 0;
}


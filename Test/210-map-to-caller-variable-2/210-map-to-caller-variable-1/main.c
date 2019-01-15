extern int getenv(const char *name);

int
foo(int tainted)
{
    return tainted;
}

int
main()
{
    int tainted = getenv("gude");
    int rc = foo(tainted);

    return rc;
}


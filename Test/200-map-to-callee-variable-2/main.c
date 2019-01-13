extern char *getenv(const char *name);

void
foo(char *tainted)
{
    char *also_tainted1 = tainted;
    tainted = "noe";
    char *not_tainted = tainted;
}

int
main()
{
    char *tainted = getenv("gude");
    foo(tainted);

    return 0;
}


extern char *getenv(const char *name);

void
bar(char *tainted_bar, char *not_tainted)
{
    char *tainted2 = tainted_bar;
    char *not_tainted2 = not_tainted;
}

void
foo(char *tainted_foo)
{
    char *also_tainted = tainted_foo;
    char *not_tainted = "noe";
    bar(tainted_foo, not_tainted);
}

int
main()
{
    char *tainted_main = getenv("gude");
    foo(tainted_main);

    return 0;
}


extern int getenv(const char *name);

int
foo()
{
    int t = getenv("gude");
    return t+1;
}

int
main()
{
    int a = 0;

    if (a) {
        return foo() + 1;
    }

    return 0;
}


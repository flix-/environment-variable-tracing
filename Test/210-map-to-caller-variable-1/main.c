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
    int t = foo();

    int t2 = t;

    return 0;
}


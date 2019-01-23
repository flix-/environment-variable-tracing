extern char* getenv(const char *name);

char *
foo(char *t1)
{
    char *t2 = t1;

    return t2;
}

int
main()
{
    char *t1 = getenv("gude");

    char *t2 = foo(t1);

    char *t3 = t2;

    return 0;
}


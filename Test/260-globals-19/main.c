extern char *getenv(const char *name);

char *gt;

char *
foo(char *param) {
    char *t1 = param;

    param = "nope";

    char *ut1 = param;

    return param;
}

int
main()
{
    gt = getenv("gude");

    char *t1 = gt;

    char *ret = foo(gt);
    char *ut2 = ret;

    char *t2 = gt;

    return 0;
}


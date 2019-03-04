extern char *getenv(const char *name);

char **
foo() {
    char *str[2];
    str[1] = getenv("gude");

    // evil...
    return str;
}

int
main()
{
    char **str = foo();

    char *ut = str[0];
    char *t = str[1];

    return 0;
}


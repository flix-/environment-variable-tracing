extern char *getenv(const char *name);

char *
foo() {
    char *str[2];
    str[1] = getenv("gude");

    return str[1];
}

int
main()
{
    char *str = foo();

    char *t = str;

    return 0;
}


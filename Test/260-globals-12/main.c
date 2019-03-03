extern char *getenv(const char *name);
extern int foo();
extern int bar();

char *str[1024];

int
foo(char *s[]) {
    char *t1 = s[2];

    char *ut1 = s[1];

    return 0;
}

int
main()
{
    str[2] = getenv("gude");

    int rc = foo(str);

    return rc;
}


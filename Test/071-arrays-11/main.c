extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *str[2];
    str[0] = getenv("gude");
    str[1] = str[0];

    char *t = str[1];

    str[0] = 0;
    str[1] = str[0];

    return 0;
}


extern char *getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    char *str[2];
    str[1] = getenv("gude");

    char **arr_decay = str;

    char *ut1 = arr_decay[0];
    char *t1 = arr_decay[1];

    return 0;
}


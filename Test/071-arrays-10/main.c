extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct s2 {
    char *strings[2];
};

struct s1 {
    int a;
    int b;
    struct s2 s2;
};

int
main()
{
    struct s1 s1;
    s1.s2.strings[1] = getenv("gude");

    char **arr_decay = s1.s2.strings;

    char *ut1 = arr_decay[0];
    char *t1 = arr_decay[1];

    return 0;
}


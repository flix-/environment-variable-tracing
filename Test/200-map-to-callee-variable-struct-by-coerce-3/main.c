extern char *getenv(const char *name);

struct s1 {
    int a;
    int b;
    char *tainted1;
};

void
bar(struct s1 str_bar) {
    char *tainted_bar = str_bar.tainted1;
    str_bar.tainted1 = "untaint";
}

void
foo(struct s1 str_foo, int a)
{
    char *tainted_foo = str_foo.tainted1;
    bar(str_foo);
    char *still_tainted = str_foo.tainted1;
}

int
main()
{
    struct s1 str_main;
    str_main.tainted1 = getenv("gude");
    foo(str_main, 42);

    return 0;
}


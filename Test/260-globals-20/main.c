extern char *getenv(const char *name);

struct s2 {
    char *ut;
    char *t;
};

struct s1 {
    char *t;
    struct s2 s2;
};

struct s1 s1;

void
bar() {
    s1.s2.t = "nope";
}

void
foo(struct s2 s2) {
    char *t1 = s1.s2.t;
    char *t2 = s2.t;
    char *ut1 = s2.ut;

    bar();

    char *ut2 = s1.s2.t;
}

int
main()
{
    s1.s2.t = getenv("gude");

    foo(s1.s2);

    char *ut1 = s1.s2.t;

    return 0;
}


extern char *getenv(const char *);

struct s2 {
    int a;
    int b;
    char *t1;
};

struct s1 {
    double a;
    struct s2 s2;
};

char *
foo(struct s1 s1) {
    char *tainted = s1.s2.t1;

    return tainted;
}

int
main() {
    struct s1 s1;
    s1.s2.t1 = getenv("gude");

    char * (*foo_ptr)(struct s1) = &foo;

    char *ret = foo_ptr(s1);

    char *t1 = ret;

    return 0;
}


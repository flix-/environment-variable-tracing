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
foo(struct s1 foo_s1) {
    char *tainted = foo_s1.s2.t1;

    return tainted;
}

char *
executor(char * (*f_ptr)(struct s1), struct s1 executor_s1) {
    return f_ptr(executor_s1);
}

int
main() {
    struct s1 main_s1;
    main_s1.s2.t1 = getenv("gude");

    char * (*foo_ptr)(struct s1) = &foo;

    char *ret = executor(foo_ptr, main_s1);

    char *t1 = ret;

    return 0;
}


extern char *getenv(const char *);

struct s1 {
    int a;
    int b;
    char *t1;
};

int
main() {
    struct s1 s1;
    s1.t1 = getenv("gude");

    s1.a = (int)s1.t1;

    return 0;
}


extern char *getenv(const char *);

struct s1 {
    char *t1;
    int a;
    int b;
};

int
main() {
    struct s1 s1;
    s1.t1 = getenv("gude");

    long i = s1.t1 || 1;

    char *t1 = (char *)i;

    return 0;
}


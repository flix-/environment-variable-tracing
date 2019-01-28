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

    char *t = (char *)&s1;

    return 0;
}


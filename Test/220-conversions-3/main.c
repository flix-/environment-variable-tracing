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

    float f = s1.t1 || 1;
    unsigned int t1 = f;

    int t2 = f;

    return 0;
}


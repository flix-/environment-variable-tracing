extern char *getenv(const char*);

struct s3 {
    char *tainted;
};

struct s1 {
    int a;
    struct s3 *ps3;
};

int
main()
{
    struct s3 sss;
    sss.tainted = getenv("gude");

    struct s1 s;
    s.ps3 = &sss;

    return 0;
}


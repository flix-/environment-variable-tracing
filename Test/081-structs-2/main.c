extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct c {
    char *a;
};

struct b {
    struct c a;
};

struct a {
    char *a;
    struct b b;
};

int
main()
{
    struct a foo;
    foo.a = getenv("gude");
    foo.b.a.a = foo.a;

    char *a = foo.b.a.a;

    foo.b.a.a = "untaint";

    a = foo.b.a.a;

    return 0;
}


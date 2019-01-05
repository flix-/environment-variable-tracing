extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct c {
    char *a;
};

struct b {
    struct c a[2];
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
    foo.b.a[0].a = foo.a;

    char *a = foo.b.a[0].a;

    foo.b.a[0].a = "untaint";

    a = foo.b.a[0].a;

    return 0;
}


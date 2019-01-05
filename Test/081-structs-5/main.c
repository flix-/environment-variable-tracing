extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct c {
    char *a[2];
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
    struct a bar;
    foo.a = getenv("gude");
    foo.b.a[0].a[0] = foo.a;

    char *a = foo.b.a[0].a[0];
    char *b = bar.b.a[0].a[0];

    foo.b.a[0].a[0] = "untaint";

    a = foo.b.a[0].a[0];

    return 0;
}


extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct b {
    char *taint;
};

struct a {
    int a;
    struct b b;
};

int
main()
{
    struct a a1;
    a1.b.taint = getenv("gude");

    struct a a2 = a1;
    char *t = a2.b.taint;

    return 0;
}


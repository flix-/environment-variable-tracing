extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct b {
    char *taint;
    char *taint2;
};

struct a {
    int a;
    struct b b;
    char *tainted;
};

int
main()
{
    struct a s1;
    s1.tainted = getenv("hi");
    s1.b.taint = s1.tainted;
    s1.b.taint2 = s1.b.taint;

    char *tainted = s1.tainted;
    char *tainted1 = s1.b.taint;
    char *tainted2 = s1.b.taint2;

    struct b s2_inner;
    s1.b = s2_inner;

    char *not_tainted1 = s1.b.taint;
    char *not_tainted2 = s1.b.taint2;

    char *tainted3 = s1.tainted;

    return 0;
}


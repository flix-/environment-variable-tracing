extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct d {
    int a;
    int b;
    char *taint;
};

struct c {
    double a;
    char *taint;
    struct d d;
};

struct b {
    int f;
    char *taint;
    struct c c;
};

struct a {
    int a;
    struct b b;
};

int
main()
{
    struct a a1;
    a1.b.c.d.taint = getenv("gude");

    struct c c1 = a1.b.c;
    char *t1 = c1.d.taint;

    struct d d1 = c1.d;
    char *t2 = d1.taint;

    c1.d.taint = "untaint";
    char *ut1 = c1.d.taint;
    
    char *t3 = d1.taint;

    return 0;
}


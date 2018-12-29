extern char *getenv(const char *name);
extern int foo();
extern int bar();

union u2 {
    int a;
    char *taint;
};

union u1 {
    int a;
    double b;
    union u2 u;
};

int
main()
{
    union u1 un;
    un.u.taint = getenv("hello world");

    char *a = un.u.taint;

    un.u.a = 1;

    char *b = un.u.taint;

    return 0;
}


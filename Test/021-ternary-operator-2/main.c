extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = getenv("gude") == 0 ? foo() : 1;
    int a = taint;

    if (foo()) {
        int a = 0;
    } else {
        int b = 0;
    }

    int ut = 1;

    return 0;
}


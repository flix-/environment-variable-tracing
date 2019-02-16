extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = getenv("hi") && bar();
    int a = taint;

    int no_taint = 1;
    if (no_taint) {
        int a = 0;
    } else {
        int b = 0;
    }

    return 0;
}


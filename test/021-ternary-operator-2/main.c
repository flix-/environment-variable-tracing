extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = getenv("gude") == 0 ? foo() : 1;
    int a = taint;

    return 0;
}


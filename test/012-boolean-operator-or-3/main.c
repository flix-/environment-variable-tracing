extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int taint = bar() || foo() || getenv("hi");
    int a = taint;

    return 0;
}


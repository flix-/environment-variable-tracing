extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int a = getenv("hi");
    int *b = &a;

    *b = 1;

    int c = *b;

    return 0;
}


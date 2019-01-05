extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int no_taint = foo() == 0 ? 0 : 1;

    return 0;
}


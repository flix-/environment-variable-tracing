extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    do {
        int a = 100;
    } while (foo());

    return 0;
}


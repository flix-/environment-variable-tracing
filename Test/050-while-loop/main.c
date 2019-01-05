extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    while (foo()) {
        int a = 100;
    }

    return 0;
}


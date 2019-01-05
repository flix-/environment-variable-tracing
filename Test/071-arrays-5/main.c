extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int numbers[2][2];
    numbers[0][0] = 42;
    numbers[0][1] = getenv("gude");
    numbers[1][0] = numbers[0][1];

    int rc = numbers[0][0];

    return rc;
}


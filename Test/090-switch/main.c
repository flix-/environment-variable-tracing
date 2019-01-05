extern int getenv(const char *name);
extern int foo();
extern int bar();

int
main()
{
    int rc = foo();
    switch (rc) {
    case 0:
        rc = 1;
        break;
    case 1:
        rc = 2;
        break;
    default:
        rc = 3;
    }

    return 0;
}


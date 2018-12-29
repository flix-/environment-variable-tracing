extern char *getenv(const char *name);
extern int foo();
extern int bar();

struct t {
    char *taint[2];
};

struct s {
    int a;
    struct t b;
};

int
main()
{
    struct s str_array[2][2];
    struct s str_array2[2][2];
    str_array[0][0].b.taint[0] = getenv("gude");
    str_array[0][1].b.taint[1] = str_array[0][0].b.taint[0];
    
    char *tainted1 = str_array[0][0].b.taint[0];
    char *tainted2 = str_array[0][1].b.taint[1];

    char *not_tainted1 = str_array2[0][0].b.taint[0];
    char *not_tainted2 = str_array2[0][1].b.taint[1];

    str_array[0][0].b.taint[0] = "untaint";

    tainted1 = str_array[0][0].b.taint[0];
    
    char *not_tainted = tainted1;

    return 0;
}


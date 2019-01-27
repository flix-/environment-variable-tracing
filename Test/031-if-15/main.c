#include <stdlib.h>

extern char *getenv(const char *name);

struct s1 {
    char *t1;
    char *ut1;
};

int
main()
{
    struct s1 *s1 = (struct s1*)malloc(sizeof(struct s1));
    if (!s1) return -1;

    s1->t1 = getenv("gude");

    if (s1 != NULL) {
        int a = 4711;
    }

    return 0;
}


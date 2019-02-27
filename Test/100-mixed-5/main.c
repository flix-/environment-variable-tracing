#include "stdlib.h"

extern char *getenv(const char *);

struct SH {
    int arena_size;
    char *arena;
    int minsize;
    int freelist_size;
};

static struct SH sh;

static int
sh_getlist(char *ptr) {
    int size = sh.freelist_size - 1;

    int bit = (sh.arena_size + ptr - sh.arena) / sh.minsize;

    int t = bit;

    return 0;
}

int
main() {
    char *ptr = getenv("gude");

    int rc = sh_getlist(ptr);

    return rc;
}


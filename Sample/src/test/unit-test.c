#include <dlfcn.h>

#include "../config/config.h"

int
main()
{
    char *so_filename = "/home/sebastian/.qt-creator-workspace/Phasar/Sample/src/sample.so";

    void *handle = dlopen(so_filename, RTLD_NOW);
    if (!handle) return -1;

    struct config * (*get_config)() = dlsym(handle, "get_config");
    if (!get_config) return -1;

    get_config();

    dlclose(handle);

    return 0;
}


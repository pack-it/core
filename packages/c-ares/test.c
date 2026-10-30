// See: https://c-ares.org/docs.html#examples
#include <stdio.h>
#include <ares.h>

int main() {
    ares_library_init(ARES_LIB_INIT_ALL);

    // Check if ares is compiled with thread safety enabled
    if (!ares_threadsafety()) {
        printf("Test failed: c-ares not compiled with thread support\n");
        return 1;
    }

    ares_library_cleanup();
    return 0;
}
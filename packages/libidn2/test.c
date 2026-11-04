#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <idn2.h>

int main() {
    char *output = NULL;

    // Convert UTF-8 example to ASCII
    int result = idn2_to_ascii_8z("påçkît", &output, IDN2_NONTRANSITIONAL);
    if (result != IDN2_OK) {
        printf("Test failed: %s\n", idn2_strerror(result));
        return 1;
    }
    
    // Check if converted output is expected output
    if (strcmp(output, "xn--pkt-ulak7b") != 0) {
        printf("Test failed: test output '%s' does not match the expected output\n", output);
        return 1;
    }
    
    free(output);
    return 0;
}

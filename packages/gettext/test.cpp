#include <stdio.h>
#include <locale.h>
#include <autosprintf.h>
#include <textstyle.h>
#include <cstring>

#ifndef __GLIBC__
    #include <libintl.h>
#endif

int main() {
    setlocale(LC_ALL, "");

    // Only test libintl if not glibc
    #ifdef __GLIBC__
        dprintf(3, "Skipping libintl test\n");
    #else
        // Bind a missing domain
        bindtextdomain("missing", "./missing");
        textdomain("missing");

        // Try to get text, expected result is the fallback text
        char *text = gettext("The translation for this text is missing, if you see this, the fallback works fine!");
        if (strcmp(text, "The translation for this text is missing, if you see this, the fallback works fine!") != 0) {
            printf("Test failed: test output '%s' does not match the expected output\n", text);
            return 1;
        }
    #endif

    // Test libasprintf
    char *message = NULL;

    int result = asprintf(&message, "Hello %s!", "Packit");
    if (result == -1) {
        printf("Test failed: failed to print test text to string\n");
        return 1;
    }

    if (strcmp(message, "Hello Packit!") != 0) {
        printf("Test failed: test output '%s' does not match the expected output\n", message);
        free(message);
        return 1;
    }

    free(message);
    return 0;
}

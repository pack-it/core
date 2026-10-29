#include <stdio.h>
#include <string.h>
#include <unicode/unum.h>
#include <unicode/ustring.h>

int main(void) {
    double number = 7.3;
    UErrorCode status = U_ZERO_ERROR;

    // Number formatter using the German locale
    UNumberFormat *formatter = unum_open(UNUM_DECIMAL, NULL, 0, "de_DE", NULL, &status);
    if (U_FAILURE(status)) {
        fprintf(stderr, "Test failed: could not create formatter: %s\n", u_errorName(status));
        return 1;
    }

    // Format the number into a UTF-16 buffer
    UChar formatted[100];
    int32_t length = unum_formatDouble(formatter, number, formatted, 100, NULL, &status);
    if (U_FAILURE(status)) {
        fprintf(stderr, "Test failed: formatting failed: %s\n", u_errorName(status));
        unum_close(formatter);
        return 1;
    }

    // Convert UTF-16 to UTF-8 for `strcmp`
    char output[400];
    int32_t outputLength;
    u_strToUTF8(output, sizeof(output), &outputLength, formatted, length, &status);
    if (U_FAILURE(status)) {
        fprintf(stderr, "Test failed: UTF-16 to UTF-8 conversion failed: %s\n", u_errorName(status));
        unum_close(formatter);
        return 1;
    }

    if (strcmp(output, "7,3")) {
        fprintf(stderr, "Test failed: buffer was '%s' expected value '7,3'\n", output);
        unum_close(formatter);
        return 1;
    }

    unum_close(formatter);
    return 0;
}

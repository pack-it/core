#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <unistr.h>
#include <unictype.h>
#include <uniname.h>

int main() {
    const uint8_t *text = (const uint8_t *)"Héllo";

    // Validate text string
    if (u8_check(text, strlen((const char *)text)) != NULL) {
        printf("Test failed: failed to validate string\n");
        return 1;
    }

    // Check length of the text
    if (u8_mbsnlen(text, strlen((const char *)text)) != 5) {
        printf("Test failed: failed to check length of string\n");
        return 1;
    }

    // Check character type
    if (!uc_is_alpha(0x00E9) || !uc_is_digit('7')) {
        printf("Test failed: failed to check character type\n");
        return 1;
    }

    // Find substring 'llo'
    if (u8_strstr(text, (const uint8_t *)"llo") == NULL) {
        printf("Test failed: failed to find substring 'llo'\n");
        return 1;
    }

    // Find PACKAGE unicode char
    ucs4_t uc = unicode_name_character("PACKAGE");
    if (uc == UNINAME_INVALID) {
        printf("Test failed: failed to find character 'PACKAGE'\n");
        return 1;
    }

    // Write PACKAGE char to buffer
    uint8_t buffer[6];
    int length = u8_uctomb(buffer, uc, sizeof(buffer));
    if (length < 0) {
        printf("Test failed: failed to add unicode char to buffer\n");
        return 1;
    }
    buffer[length] = '\0';

    // Write PACKAGE char to stdout
    printf("%s\n", buffer);

    return 0;
}

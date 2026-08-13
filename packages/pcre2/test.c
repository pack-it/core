/* Test code for pcre2, based on the example in the README at https://github.com/PCRE2Project/pcre2#quickstart. */
#define PCRE2_CODE_UNIT_WIDTH 8
#include <pcre2.h>
#include <string.h>
#include <stdio.h>

int main() {
    const char *pattern = "test";
    const char *subject = "test subject";

    // Compile the pattern
    int error_number;
    PCRE2_SIZE error_offset;
    pcre2_code *regex = pcre2_compile((PCRE2_SPTR8) pattern, PCRE2_ZERO_TERMINATED, 0, &error_number, &error_offset, NULL);
    if (regex == NULL) {
        fprintf(stderr, "Invalid pattern: %s\n", pattern);
        return 1;
    }

    // Match the pattern against the subject text
    pcre2_match_data *match_data = pcre2_match_data_create_from_pattern(regex, NULL);
    int result = pcre2_match(regex, (PCRE2_SPTR8) subject, strlen(subject), 0, 0, match_data, NULL);

    // Print the match result
    if (result == PCRE2_ERROR_NOMATCH) {
        printf("No match found, expected pattern '%s' to match with '%s'\n", pattern, subject);
        return 1;
    } else if (result < 0) {
        fprintf(stderr, "Matching error\n");
        return 1;
    } else {
        PCRE2_SIZE *ovector = pcre2_get_ovector_pointer(match_data);
        printf("Found match: '%.*s'\n", (int)(ovector[1] - ovector[0]), subject + ovector[0]);
    }

    pcre2_match_data_free(match_data);
    pcre2_code_free(regex);

    return 0;
}

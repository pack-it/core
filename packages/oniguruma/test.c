#include <stdio.h>
#include <string.h>
#include <oniguruma.h>

int main() {
    int result;
    OnigUChar pattern[] = "world";
    OnigUChar input[] = "hello 123 world";

    OnigEncoding encodings[] = { ONIG_ENCODING_UTF8 };

    result = onig_initialize(encodings, 1);
    if (result != ONIG_NORMAL) {
        printf("Test failed: oniguruma initialization failed\n");
        return 1;
    }

    // Compile the regex
    OnigRegex regex;
    OnigErrorInfo error_info;
    result = onig_new(
        &regex,
        pattern,
        pattern + strlen((char *)pattern),
        ONIG_OPTION_NONE,
        ONIG_ENCODING_UTF8,
        ONIG_SYNTAX_GNU_REGEX,
        &error_info
    );
    
    if (result != ONIG_NORMAL) {
        OnigUChar error[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(error, result, &error_info);
        printf("Test failed: regex compilation failed: %s\n", error);
        onig_free(regex);
        onig_end();
        return 1;
    }

    // Perform regex search
    OnigRegion *region = onig_region_new();
    result = onig_search(
        regex,
        input,
        input + strlen((char *)input),
        input,
        input + strlen((char *)input),
        region,
        ONIG_OPTION_NONE
    );

    if (result == ONIG_MISMATCH) {
        printf("Test failed: no match found\n");
        onig_region_free(region, 1);
        onig_free(regex);
        onig_end();
        return 1;
    }

    if (result <= 0) {
        OnigUChar error[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(error, result, NULL);
        printf("Test failed: error during search: %s\n", error);
        onig_region_free(region, 1);
        onig_free(regex);
        onig_end();
        return 1;
    }

    onig_region_free(region, 1);
    onig_free(regex);
    onig_end();

    return 0;
}

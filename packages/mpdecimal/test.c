#include <mpdecimal.h>
#include <string.h>
#include <stdio.h>

int main() {
    mpd_context_t ctx;
    mpd_defaultcontext(&ctx);
    uint32_t status = 0;

    mpd_t *num_a, *num_b, *result;
    num_a = mpd_new(&ctx);
    num_b = mpd_new(&ctx);
    result = mpd_new(&ctx);

    // Set a and b form a string (strings preserve the input value exactly)
    mpd_qset_string(num_a, "0.1", &ctx, &status);
    if (status != 0) {
        printf("Test failed: failed to create 'a' with value '0.1'\n");
        mpd_del(num_a);
        mpd_del(num_b);
        mpd_del(result);
        return 1;
    }

    mpd_qset_string(num_b, "0.2", &ctx, &status);
    if (status != 0) {
        printf("Test failed: failed to create 'b' with value '0.2'\n");
        mpd_del(num_a);
        mpd_del(num_b);
        mpd_del(result);
        return 1;
    }

    mpd_add(result, num_a, num_b, &ctx);

    // Compare the numbers
    int compare = mpd_qcmp(num_a, num_b, &status);
    if (compare == -1) {
        printf("a < b\n");
    } else if (compare == 0) {
        printf("a == b\n");
    } else if (compare == 1) {
        printf("Test failed: a > b\n");
        mpd_del(num_a);
        mpd_del(num_b);
        mpd_del(result);
        return 1;
    } else {
        printf("Test failed: comparison failed with NaN\n");
        mpd_del(num_a);
        mpd_del(num_b);
        mpd_del(result);
        return 1;
    }

    mpd_del(num_a);
    mpd_del(num_b);
    mpd_del(result);

    return 0;
}

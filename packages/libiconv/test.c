#include <stdio.h>
#include <stdlib.h>
#include <iconv.h>

int main(int argc, char **argv) {
    // Open test.txt file
    FILE *file = fopen("test.txt", "rb");
    if (file == NULL) {
        printf("Test failed: failed to open test.txt\n");
        return 1;
    }

    // Get file length
    fseek(file, 0, SEEK_END);
    long file_length = ftell(file);
    rewind(file);

    // Read file into buffer
    size_t input_size = (size_t)file_length;
    char *input = malloc(input_size);
    if (input == NULL) {
        printf("Test failed: failed to allocate input buffer\n");
        free(input);
        return 1;
    }
    if (fread(input, 1, input_size, file) != input_size) {
        printf("Test failed: failed to read test.txt\n");
        return 1;
    }
    fclose(file);

    // Create output buffer
    size_t output_size = (size_t)file_length / 2;
    char *output = calloc(output_size, 1);
    if (output == NULL) {
        printf("Test failed: failed to allocate output buffer\n");
        free(input);
        return 1;
    }

    // Create iconv converter
    iconv_t converter = iconv_open("UTF-8", "UTF-16LE");
    if (converter == (iconv_t)-1) {
        printf("Test failed: failed to create iconv converter\n");
        return 1;
    }

    // Copy pointers
    char *input_ptr = input;
    char *output_ptr = output;
    size_t input_remaining = input_size;
    size_t output_remaining = output_size;

    // Convert input
    size_t result = iconv(converter, &input_ptr, &input_remaining, &output_ptr, &output_remaining);
    if (result == (size_t)-1) {
        printf("Test failed: failed to convert input\n");
        free(input);
        free(output);
        iconv_close(converter);
        return 1;
    }

    // Write converted data to stdout
    size_t converted_size = output_ptr - output;
    fwrite(output, 1, converted_size, stdout);

    free(input);
    free(output);
    iconv_close(converter);
    return 0;
}

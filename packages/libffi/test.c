#include <stdio.h>
#include <ffi.h>

int add(int a, int b) {
    return a + b;
}

int main(void) {
    // Define the argument types
    ffi_type *arg_types[] = {&ffi_type_sint, &ffi_type_sint};

    // Create the values and store references to them
    int a = 1760728831;
    int b = 1;
    void *values[] = {&a, &b};

    // Create cif which knows how to call the (add) function
    ffi_cif cif;
    ffi_status status = ffi_prep_cif(
        &cif,
        FFI_DEFAULT_ABI,
        2,
        &ffi_type_sint,
        arg_types
    );

    if (status != FFI_OK) {
        printf("Failed to create cif\n");
        return 1;
    }

    // Execute the add function with help of the cif
    int result;
    ffi_call(
        &cif,
        FFI_FN(add),
        &result,
        values
    );

    if (result != 1760728832) {
        printf("Result is '%d' instead of '1760728832'\n", result);
        return 1;
    }

    printf("Result is '%d'\n", result);
    return 0;
}

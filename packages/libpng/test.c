#include <stdio.h>
#include <png.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    FILE *fp = fopen("test.png", "rb");
    if (!fp) {
        return 1;
    }

    png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    if (!png_ptr) {
        return 1;
    }

    png_destroy_read_struct(&png_ptr, (png_infopp)NULL, (png_infopp)NULL);
    return 0;
}

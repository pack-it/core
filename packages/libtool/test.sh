#!/bin/sh

cat << EOF > test.c
#include <stdio.h>

void test() {
    printf("Libtool works, time to build some libraries!\n");
}
EOF

cat << EOF > main.c
#include <stdio.h>
void test();

int main() {
    test();
    return 0;
}
EOF

libtool="$PACKIT_PACKAGE_PATH/bin/libtool"
if [ "$PACKIT_OS" = "mac" ]; then
    libtool="$PACKIT_PACKAGE_PATH/bin/glibtool"
fi

"$libtool" --mode=compile gcc -c test.c -o test.lo >&3
"$libtool" --mode=link gcc -shared -o libtest.la test.lo >&3

"$libtool" --mode=compile gcc -c main.c -o main.lo >&3
"$libtool" --mode=link gcc -o main main.lo libtest.la >&3

expected_output="Libtool works, time to build some libraries!"
output=$(./main)

if [ "$output" != "$expected_output" ]; then
    echo "Test failed: test program did not print the expected output"
    exit 1
fi

libtoolize="$PACKIT_PACKAGE_PATH/bin/libtoolize"
if [ "$PACKIT_OS" = "mac" ]; then
    libtoolize="$PACKIT_PACKAGE_PATH/bin/glibtoolize"
fi

"$libtoolize" --ltdl >&3

if [ ! -d libltdl ]; then
    echo "Test failed: libtoolize did not create the libltdl directory"
    exit 1
fi

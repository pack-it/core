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

"$libtool" --mode=compile gcc -c test.c -o test.lo >/dev/null
"$libtool" --mode=link gcc -shared -o libtest.la test.lo >/dev/null

"$libtool" --mode=compile gcc -c main.c -o main.lo >/dev/null
"$libtool" --mode=link gcc -o main main.lo libtest.la >/dev/null

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

"$libtoolize" --ltdl >/dev/null

if [ ! -d libltdl ]; then
    echo "Test failed: libtoolize did not create the libltdl directory"
    exit 1
fi

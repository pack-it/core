#!/bin/sh

cat << "EOF" > test.pc
prefix=/opt/packit/packages/test/1.0.0
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: test
Description: The official packit test library (very real library)
Version: 1.0.0
URL: https://github.com/pack-it/packit
Libs: -L${libdir} -ltest
Cflags: -I${includedir}
EOF

# Set PKG_CONFIG_PATH to the current directory
export PKG_CONFIG_PATH="$(pwd)"

"$PACKIT_PACKAGE_PATH/bin/pkgconf" --validate test

expected_output="-L/opt/packit/packages/test/1.0.0/lib"
output=$("$PACKIT_PACKAGE_PATH/bin/pkgconf" --libs-only-L test)
if [ "$output" != "$expected_output" ]; then
    echo "Test failed: libs test did not give the correct output"
    exit 1
fi

expected_output="-I/opt/packit/packages/test/1.0.0/include"
output=$("$PACKIT_PACKAGE_PATH/bin/pkgconf" --cflags-only-I test)
if [ "$output" != "$expected_output" ]; then
    echo "Test failed: cflags test did not give the correct output"
    exit 1
fi

expected_output="/opt/packit/packages/test/1.0.0/lib"
output=$("$PACKIT_PACKAGE_PATH/bin/pkgconf" --variable=libdir test)
if [ "$output" != "$expected_output" ]; then
    echo "Test failed: variable test did not give the correct output"
    exit 1
fi

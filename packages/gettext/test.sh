#!/bin/sh

# Only link to libintl if not using glibc
intl_flag=""
if ! getconf GNU_LIBC_VERSION 2>&3 >&3; then
    intl_flag="-lintl"
fi

g++ -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.cpp -o test -lasprintf $intl_flag

./test

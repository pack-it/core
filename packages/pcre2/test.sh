#!/bin/sh

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lpcre2-8

./test >&3

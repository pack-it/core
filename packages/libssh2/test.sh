#!/bin/sh

# Compile test.c
gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lssh2

# Run the file to see if libssh2 works
./test

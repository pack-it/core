#!/bin/sh

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -lgit2

./test >&3

# Check if test created git repository
if [ ! -d .git ]; then
    echo "Test failed: libgit2 test did not create the .git directory"
    exit 1
fi

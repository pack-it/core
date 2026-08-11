#!/bin/sh

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -ljson-c

# The test only prints output when it fails
./test

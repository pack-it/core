#!/bin/sh

# Compile test.c
gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -lexpat

output=`./test`
expected_output="The count of Numeria says one, two, three, four, five, the thing that comes after five. AAaahhh this happens everytimeee!!"

if [ "$output" = "$expected_output" ]; then
    exit 0
fi

exit 1

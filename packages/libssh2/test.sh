#!/bin/sh

# Compile test.c 
if [ $PACKIT_OS = "linux" ]; then
    # Specifically specify the rpath, otherwise libssh2.so.1 cannot be found at runtime
    gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -lssh2
else
    gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" test.c -o test -lssh2
fi

# Run the file to see if libssh2 works
./test

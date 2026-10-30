#!/bin/sh

g++ -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.cpp -o test -lsimdjson

./test >&3

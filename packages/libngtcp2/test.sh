#!/bin/sh

gcc -L "$PACKIT_PACKAGE_PATH/lib" -I "$PACKIT_PACKAGE_PATH/include" -Wl,-rpath,"$PACKIT_PACKAGE_PATH/lib" test.c -o test -lngtcp2 -lngtcp2_crypto_ossl

./test >&3

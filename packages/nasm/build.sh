#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# TODO: Test on x86-64
# Skip the execution on ARM based targets, because NASM is not build for it
if [ "$PACKIT_TARGET" != "aarch64-apple-darwin" ] || [ "$PACKIT_OS" = "aarch64-unknown-linux-gnu" ] ; then
    make test
fi



make install

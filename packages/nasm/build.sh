#!/bin/sh
cd nasm-$PACKIT_ARGS_REAL_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install

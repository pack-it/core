#!/bin/sh
cd libedit-$PACKIT_ARGS_DATE_VERSION-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make check

make install

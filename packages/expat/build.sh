#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --mandir="$PACKIT_PACKAGE_PATH/share/man"

make

make check

make install

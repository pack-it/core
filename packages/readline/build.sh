#!/bin/sh
cd readline-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --with-curses

make

make install

#!/bin/sh
cd ncurses-6.5

./configure --prefix=$PACKIT_PACKAGE_PATH --enable-symlinks
# TODO: Add --enable-widec and implement symlink creation

make

make install

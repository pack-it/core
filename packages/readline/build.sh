#!/bin/sh
cd readline-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --with-curses

make SHLIB_LIBS="$PACKIT_PREFIX_PATH/dependencies/readline@$PACKIT_PACKAGE_VERSION/ncurses/lib/libcurses.so"

make install

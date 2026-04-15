#!/bin/sh
cd readline-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH --with-curses

if [ "$PACKIT_OS" = "mac" ]; then
    path="-lcurses"
fi

if [ "$PACKIT_OS" = "linux" ]; then
    path="$PACKIT_PACKAGE_DEPENDENCIES_PATH/ncurses/lib/libcurses.so"
fi

make SHLIB_LIBS=$path

make install

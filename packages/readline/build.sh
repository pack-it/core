#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH --with-curses

if [ "$PACKIT_OS" = "mac" ]; then
    path="-lcurses"
fi

if [ "$PACKIT_OS" = "linux" ]; then
    path="$PACKIT_PACKAGE_DEPENDENCIES_PATH/ncurses/lib/libcurses.so"
fi

make SHLIB_LIBS=$path -j $PACKIT_BUILD_JOBS_COUNT

make install

#!/bin/sh
cd libedit-$PACKIT_ARGS_DATE_VERSION-$PACKIT_PACKAGE_VERSION

if [ "$PACKIT_OS" = "mac" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH
fi

if [ "$PACKIT_OS" = "linux" ]; then
    ./configure --prefix=$PACKIT_PACKAGE_PATH \
        CPPFLAGS="-I$PACKIT_PACKAGE_DEPENDENCIES_PATH/ncurses/include" \
        LDFLAGS="-L$PACKIT_PACKAGE_DEPENDENCIES_PATH/ncurses/lib -lncurses"
fi

make

make check

make install

# Change working directory to package path to create readline compatibility symlinks
cd $PACKIT_PACKAGE_PATH

mkdir -p libexec/include/readline
mkdir -p libexec/lib
ln -s ../../../include/editline/readline.h libexec/include/readline/history.h
ln -s ../../lib/libedit.a libexec/lib/libhistory.a

ln -s ../../../include/editline/readline.h libexec/include/readline/readline.h
ln -s ../../lib/libedit.a libexec/lib/libreadline.a

if [ "$PACKIT_OS" = "mac" ]; then
    ln -s ../../lib/libedit.dylib libexec/lib/libhistory.dylib
    ln -s ../../lib/libedit.dylib libexec/lib/libreadline.dylib
fi

if [ "$PACKIT_OS" = "linux" ]; then
    ln -s ../../lib/libedit.so libexec/lib/libhistory.so
    ln -s ../../lib/libedit.so libexec/lib/libreadline.so
fi

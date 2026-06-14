#!/bin/sh
cd pkgconf-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install

# Create pkg-config symlinks to use pkgconf as pkg-config alternative
cd $PACKIT_PACKAGE_PATH
ln -s pkgconf bin/pkg-config
ln -s pkgconf.1 share/man/man1/pkg-config.1

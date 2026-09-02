#!/bin/sh

./configure --prefix=$PACKIT_PACKAGE_PATH

make

# Skipping build tests, because the kyua test framework is required

make install

# Create pkg-config symlinks to use pkgconf as pkg-config alternative
cd $PACKIT_PACKAGE_PATH
ln -s pkgconf bin/pkg-config
ln -s pkgconf.1 share/man/man1/pkg-config.1

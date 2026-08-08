#!/bin/sh
cd autoconf-$PACKIT_PACKAGE_VERSION

./configure --prefix=$PACKIT_PACKAGE_PATH

make

make install

# Remove unwanted standards.info file
rm -f "$PACKIT_PACKAGE_PATH"/share/info/standards.info

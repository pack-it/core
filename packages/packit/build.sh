#!/bin/sh

# Go up one level if we are in the `bin` directory and see the `pit` file
if [ -e "pit" ]; then
    cd ..
fi

# Go up one level if we are in the build directory and see the `bin` directory
if [ -e "bin" ]; then
    cd ..
fi

mkdir -p "$PACKIT_PACKAGE_PATH"
cp -R "packit@$PACKIT_PACKAGE_VERSION-0-$PACKIT_TARGET/." "$PACKIT_PACKAGE_PATH"

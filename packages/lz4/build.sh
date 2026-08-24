#!/bin/sh

make PREFIX=$PACKIT_PACKAGE_PATH

# Also executes some unnecessary speed tests
make test

make install PREFIX=$PACKIT_PACKAGE_PATH

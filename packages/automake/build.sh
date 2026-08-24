#!/bin/sh

# Set YACC to false, because it requires xcode tools, and the test is not properly skipped by automake
./configure --prefix=$PACKIT_PACKAGE_PATH YACC=false

# Modify the sed command in ./t/tap-stderr-prefix.tap to work with BSD sed
if [ "$PACKIT_OS" = "mac" ]; then
    sed -i '' '152s|${|${\
|' ./t/tap-stderr-prefix.tap

    sed -i '' '153s|/p}|/p\
}|' ./t/tap-stderr-prefix.tap
fi

make check TESTS='t/yacc-bison-skeleton' VERBOSE=1

make install

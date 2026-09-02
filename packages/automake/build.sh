#!/bin/sh

# Set YACC to false, because it requires xcode tools, and the test is not properly skipped by automake
./configure --prefix=$PACKIT_PACKAGE_PATH YACC=false

# Modify the sed command in ./t/tap-stderr-prefix.tap to work with BSD sed
if [ "$PACKIT_OS" = "mac" ]; then
    sed -i '' '152s|${|${\
|' ./t/tap-stderr-prefix.tap

    sed -i '' '153s|/p}|/p\
}|' ./t/tap-stderr-prefix.tap

    # Skip the `yacc-bison-skeleton` test, because the file containing `yyparse` is not included
    sed -i '' '/t\/yacc-bison-skeleton\.sh \\/d' Makefile 
elif [ "$PACKIT_OS" = "linux" ]; then
    sed -i '/t\/yacc-bison-skeleton\.sh \\/d' Makefile 
fi

make check VERBOSE=1

make install

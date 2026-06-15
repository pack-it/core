#!/bin/sh
cat << EOF > configure.ac
AC_INIT(autoconf-test, [1.0])
AC_CONFIG_SRCDIR([main.c])

AC_PROG_CC
AC_CHECK_FUNCS([printf])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])

AC_OUTPUT
EOF

cat << EOF > main.c
#include <stdio.h>
#include "config.h"

int main() {
#ifdef HAVE_PRINTF
    printf("Autoconf works, wooo!\n");
    return 0;
#else
    return 1;
#endif
}
EOF

cat << "EOF" > Makefile.in
CC=@CC@
CFLAGS=@CFLAGS@

all: main

main: main.c
	$(CC) $(CFLAGS) main.c -o main
EOF

"$PACKIT_PACKAGE_PATH/bin/autoheader"
"$PACKIT_PACKAGE_PATH/bin/autoconf"

if [ "$PACKIT_VERBOSE" = "1" ]; then
    ./configure
else
    ./configure >/dev/null
fi

if [ ! -e "config.status" ]; then
    echo "Test failed: config.status not found"
    exit 1
fi
if [ ! -e "config.h" ]; then
    echo "Test failed: config.h not found"
    exit 1
fi
if [ ! -e "Makefile" ]; then
    echo "Test failed: Makefile not found"
    exit 1
fi

if ! grep "#define HAVE_PRINTF 1" config.h >/dev/null; then
    echo "Test failed: config.h does not contain HAVE_PRINTF"
    exit 1
fi

if grep "@CC@" Makefile; then
    echo "Test failed: Makefile still contains an autoconf variable"
    exit 1
fi

if [ "$PACKIT_VERBOSE" = "1" ]; then
    make
else
    make >/dev/null
fi

expected_output="Autoconf works, wooo!"
output=$("./main")

if [ "$output" = "$expected_output" ]; then
    exit 0
fi

exit 1

#!/bin/sh
cat << EOF > configure.ac
AC_INIT(autoconf-test, [1.0])
AM_INIT_AUTOMAKE

AC_PROG_CC
AC_CONFIG_FILES([Makefile])

AC_OUTPUT
EOF

cat << EOF > main.c
#include <stdio.h>

int main() {
    printf("Automake works, wooo!\n");
    return 0;
}
EOF

cat << "EOF" > Makefile.am
bin_PROGRAMS = main
main_SOURCES = main.c
EOF

"$PACKIT_PACKAGE_PATH/bin/aclocal"
"$PACKIT_PACKAGE_PATH/bin/automake" --add-missing --foreign >&3 2>&3
"$PACKIT_PACKAGE_DEPENDENCIES_PATH/autoconf/bin/autoconf"

./configure >&3
make >&3

expected_output="Automake works, wooo!"
output=$("./main")

if [ "$output" = "$expected_output" ]; then
    exit 0
fi

exit 1

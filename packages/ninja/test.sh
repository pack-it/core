#!/bin/sh

cat << EOF > test.c
int main(int argc, char **argv) { return 0; }
EOF

cat << EOF > build.ninja
rule compile
  command = gcc -c \$in -o \$out

rule link
  command = gcc \$in -o \$out

build test.o: compile test.c

build test: link test.o

default test
EOF

"$PACKIT_PACKAGE_PATH/bin/ninja" >&3

./test

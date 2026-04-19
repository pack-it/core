#!/bin/sh

# Hello World example from https://cs.lmu.edu/~ray/notes/nasmtutorial/
cat << EOF > test.asm
            global    _start

            section   .text
_start:     mov       rax, 0x02000004
            mov       rdi, 1
            lea       rsi, [rel message]
            mov       rdx, 13
            syscall
            mov       rax, 0x02000001
            xor       rdi, rdi
            syscall

            section   .data
message:    db        "Hello, World", 10
EOF

"$PACKIT_PACKAGE_PATH/bin/nasm" -fmacho64 test.asm

# Link with ld, pass along the correct SDK version and path
SDK_VERSION=$(xcrun --sdk macosx --show-sdk-version)
SDK_PATH=$(xcrun --sdk macosx --show-sdk-path)
ld test.o \
  -platform_version macos "$SDK_VERSION" "$SDK_VERSION" \
  -lSystem \
  -syslibroot "$SDK_PATH" \
  -e _start \
  -o test

OUTPUT=$(./test)

if [ "$OUTPUT" != "Hello, World" ]; then
    exit 1
fi

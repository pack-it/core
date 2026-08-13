#!/bin/sh

# Hello World example from https://cs.lmu.edu/~ray/notes/nasmtutorial/
cat << EOF > test.asm
            global    _start

            section   .text
_start:     mov       rax, 1
            mov       rdi, 1
            mov       rsi, message
            mov       rdx, 13
            syscall
            mov       rax, 60
            xor       rdi, rdi
            syscall

            section   .data
message:    db        "Hello, World", 10
EOF

"$PACKIT_PACKAGE_PATH/bin/nasm" -felf64 test.asm
ld test.o

# Skip the execution on ARM based targets, because NASM is not build for it
if [ "$PACKIT_OS" = "aarch64-unknown-linux-gnu" ]; then
    exit 0
fi

output=$(./a.out)

if [ "$output" != "Hello, World" ]; then
    echo "Test failed: test output '$output' does not match the expected output"
    exit 1
fi

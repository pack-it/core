#!/bin/sh

# Hello World example from https://cs.lmu.edu/~ray/notes/nasmtutorial/
cat << EOF > test.asm
            global    start

            section   .text
start:      mov       rax, 0x02000004
            mov       rdi, 1
            mov       rsi, message
            mov       rdx, 13
            syscall
            mov       rax, 0x02000001
            xor       rdi, rdi
            syscall

            section   .data
message:    db        "Hello, World", 10
EOF

nasm -fmacho64 test.asm
ld test.o

OUTPUT=$(./a.out)

if [ "$OUTPUT" != "Hello, World"]; then
    exit 1
fi

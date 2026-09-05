```sh
#!/bin/sh

test_text="shoot for the stars, aim for the moon"

# Test Lua interpreter
result=$("$PACKIT_PACKAGE_PATH/bin/lua" -e 'print("shoot for the stars, aim for the moon")')

if [ "$result" != "$test_text" ]; then
    echo "Lua interpreter test failed"
    exit 1
fi

# Create a Lua source file
echo 'print("shoot for the stars, aim for the moon")' > test.lua

# Test running a Lua source file
result=$("$PACKIT_PACKAGE_PATH/bin/lua" test.lua)

if [ "$result" != "$test_text" ]; then
    echo "Lua script execution test failed"
    rm -f test.lua
    exit 1
fi

# Test Lua compiler
"$PACKIT_PACKAGE_PATH/bin/luac" -o test.luac test.lua

if [ $? -ne 0 ]; then
    echo "Lua compiler test failed"
    rm -f test.lua
    exit 1
fi

# Test running compiled Lua bytecode
result=$("$PACKIT_PACKAGE_PATH/bin/lua" test.luac)

if [ "$result" != "$test_text" ]; then
    echo "Lua bytecode execution test failed"
    rm -f test.lua test.luac
    exit 1
fi

rm -f test.lua test.luac


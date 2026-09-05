```sh
#!/bin/sh

cd lua-$PACKIT_PACKAGE_VERSION

# Build Lua
make

if [ $? -ne 0 ]; then
    echo "Lua build failed"
    exit 1
fi

# Install Lua into the Packit package directory
make install INSTALL_TOP="$PACKIT_PACKAGE_PATH"

if [ $? -ne 0 ]; then
    echo "Lua installation failed"
    exit 1
fi

# Move man pages to share/man
if [ -d "$PACKIT_PACKAGE_PATH/man" ]; then
    mkdir -p "$PACKIT_PACKAGE_PATH/share/man"
    mv "$PACKIT_PACKAGE_PATH/man/man1" "$PACKIT_PACKAGE_PATH/share/man/man1"
    rmdir "$PACKIT_PACKAGE_PATH/man"
fi

exit 0
```

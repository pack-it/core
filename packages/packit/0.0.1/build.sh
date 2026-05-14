#!/bin/sh

# Workaround to include Packit in core repository (Packit cannot yet be build, because Rust is not yet a supported package)
mkdir -p "$PACKIT_PACKAGE_PATH/bin/"
mv "packit@$PACKIT_PACKAGE_VERSION-0-$PACKIT_TARGET" "$PACKIT_PACKAGE_PATH/bin/packit"
ln "$PACKIT_PACKAGE_PATH/bin/packit" "$PACKIT_PACKAGE_PATH/bin/pit"

#!/bin/sh

# Redirection to /dev/null is needed to prevent flickering during test execution
# Only run test if tty is available
if [ -t 0 ]; then
    printf 'q' | "$PACKIT_PACKAGE_PATH/bin/htop" >/dev/null
fi

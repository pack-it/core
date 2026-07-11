#!/bin/sh

# Redirection to /dev/null is needed to prevent flickering during test execution
printf 'q' | "$PACKIT_PACKAGE_PATH/bin/htop" >/dev/null

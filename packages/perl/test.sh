#!/bin/sh

test_text="Me: 'Did I just see a camel walk by?', Larry: 'Oh yeah, that's my pet, he is called Perl'"
output=$("$PACKIT_PACKAGE_PATH/bin/perl" -e "print \"$test_text\n\"")
if [ "$output" != "$test_text" ]; then
    echo "Test failed: perl print test did not print the expected text"
    exit 1
fi

if ! "$PACKIT_PACKAGE_PATH/bin/perl" -e "exit(1) unless (2 + 2 == 4)"; then
    echo "Test failed: perl math test exited with status code $?"
    exit 1
fi

cat << "EOF" > test.pl
use File::Spec;
my $path = File::Spec->catfile("a", "b");
exit(1) unless $path eq "a/b";
EOF

if ! "$PACKIT_PACKAGE_PATH/bin/perl" test.pl; then
    echo "Test failed: perl file core module test exited with status code $?"
    exit 1
fi

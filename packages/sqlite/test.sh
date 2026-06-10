#!/bin/sh

db_path="test.db"
expected_output="4|Bob|25
2|Bob|10
1|Eve|17
3|Linus|20"

output=$(sqlite3 $db_path < test.sql)

if [ ! -e "$db_path" ]; then
    echo "Test failed: test database file is not created"
    exit 1
fi

if [ "$output" = "$expected_output" ]; then
    exit 0
fi

exit 1

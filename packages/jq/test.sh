#!/bin/sh

test_json="{\"title\" : \"I choked on my water\", \"choke_duration\" : 0}"
result=$(echo $test_json | "$PACKIT_PACKAGE_PATH/bin/jq" -c '.choke_duration = 30')
expected_json="{\"title\":\"I choked on my water\",\"choke_duration\":30}"

if [ "$result" != "$expected_json" ]; then
    echo "Test failed: test result '$result' does not match the expected result"
    exit 1
fi

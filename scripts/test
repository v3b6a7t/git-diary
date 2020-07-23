#!/bin/bash

echo

DIR_TESTS='./tests'

for TEST_FILE in `find $DIR_TESTS -maxdepth 1 -perm -111 -type f`; do

    echo "Running the '`basename ${TEST_FILE:0:-3}`' test"
    "$TEST_FILE" "$@"
    echo
    
done

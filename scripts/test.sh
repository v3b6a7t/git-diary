#!/bin/bash

echo

DIR_TESTS='tests'

for TEST_FILE in `ls $DIR_TESTS`; do

    PATH_FILE="$DIR_TESTS/$TEST_FILE"

    if [ -x "$PATH_FILE" ]; then
        echo "Running the '${TEST_FILE:0:-3}' test"
        "./$PATH_FILE"
        echo
    fi
    
done

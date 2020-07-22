#!/bin/bash

source "scripts/utils/test-tools.sh"
source "scripts/utils/enviroment.sh"

require_source "config"


# COMPONENT TESTING

for DIRECTORY in $INST_DIRECTORIES; do
    do_existence_test $DIRECTORY
done

for FILE in $INST_FILES; do
    do_existence_test "$FILE"
done




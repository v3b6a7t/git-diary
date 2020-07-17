#!/bin/bash

source "scripts/utils/test-tools.sh"
source "scripts/utils/enviroment.sh"

require_source "config"


# COMPONENT TESTING

do_existence_test "$DIR_SSH/$SSH_FILENAME"

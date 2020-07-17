#!/bn/bash

DIR_SCRIPTS="scripts"
DIR_DIARY="diary"
DIR_SSH=".ssh"
DIR_CONFIG=".config"

PATH_CONFIG="$DIR_CONFIG/config.conf"
PATH_DISPLAY="$DIR_SCRIPTS/utils/display.sh"
PATH_DIARY="$DIR_DIARY/index.md"


require_source() {

    VAR_NAME="PATH_${1^^}"
    REQUIRE_PATH=${!VAR_NAME}

    if [ -f "$REQUIRE_PATH" ]; 
    then source "$REQUIRE_PATH"
    else 
        echo -e "\e[41mFile '$REQUIRE_PATH' does not exist\e[0m"
        exit 0
    fi

}

require_directory() {

    VAR_NAME="DIR_${1^^}"
    REQUIRE_DIR=${!VAR_NAME}

    if [ ! -d "$REQUIRE_DIR" ]; then 
        
        if [ "$2" != "critically" ]; then 
        
            mkdir "$REQUIRE_DIR"
            require_directory "$1" "critically"
        
        else 
            
            echo -e "\e[41mDirectory '$REQUIRE_DIR' does not exist\e[0m"
        
        fi
    
    fi

}

prepare_environment() {

    require_directory "config"
    require_directory "diary"
    require_directory "ssh"

}


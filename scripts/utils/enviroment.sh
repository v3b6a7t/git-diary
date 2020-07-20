#!/bn/bash

DIR_SCRIPTS="scripts"
DIR_DIARY="diary"
DIR_SSH=".ssh"
DIR_CONFIG=".config"

PATH_CONFIG="$DIR_CONFIG/config.conf"
PATH_DISPLAY="$DIR_SCRIPTS/utils/display.sh"
PATH_DIARY="$DIR_DIARY/index.md"

INST_DIRECTORIES="$DIR_CONFIG $DIR_SSH $DIR_DIARY"
INST_FILES="$PATH_CONFIG $PATH_DIARY"


#-------------------------
# ENVIROMENT FUNCTIONS
#-------------------------

get_run_mode() {
    
    # $1 -- name value to return

    if [ ! -z $1 ]; then

        RUN_MODE=`echo "${BASH_ARGV[@]}" | grep -oP "\-{2}\w+"`
    
        if [ ! -z $RUN_MODE ]; then 
    
                printf -v $1 ${RUN_MODE:2}; 

        fi
    
    fi

}


get_run_param() {

    # $1 -- name of the expected parameter nad name value to return parameter value
    # WARNING! The message must be written as: "message_with_any_content" or "message-with-any-content"

    for (( i=1; i<=${#BASH_ARGV[@]}; i++ )); do

        if [ "${BASH_ARGV[$i]}" = "$1" ]; then

            VAR_NAME=${BASH_ARGV[$i]:2}
            VAR_NAME="__${VAR_NAME^^}__"

            VAR_VALUE="${BASH_ARGV[$(!((i+1)))]}"
            VAR_VALUE="${VAR_VALUE//[-_\"\']/ }"


            if [ ! -z $VAR_NAME ] && [ ! -z $VAR_VALUE ]; then

                printf -v $VAR_NAME "$VAR_VALUE"
            
            fi

        fi

    done

}


require_source() {

    VAR_NAME_IN_CONFIG_FILE="PATH_${1^^}"
    REQUIRE_PATH=${!VAR_NAME_IN_CONFIG_FILE}

    if [ -f "$REQUIRE_PATH" ]; then 
    
        source "$REQUIRE_PATH"
    
    else 

        echo -e "\e[41mFile '$REQUIRE_PATH' does not exist\e[0m"
        
        exit 2

    fi

}


require_directory() {

    VAR_NAME_IN_CONFIG_FILE="DIR_${1^^}"
    REQUIRE_DIR=${!VAR_NAME_IN_CONFIG_FILE}

    if [ ! -d "$REQUIRE_DIR" ]; then 
        
        if [ "$2" != "critically" ]; then 
        
            mkdir "$REQUIRE_DIR"
            
            require_directory "$1" "critically"
        
        else 
            
            echo -e "\e[41mDirectory '$REQUIRE_DIR' does not exist\e[0m"

            exit 2
        
        fi
    
    fi

}
# $1 -- name value to return

prepare_enviroment() {

    for DIRECTORY in $INST_DIRECTORIES; do
        
        require_directory ${DIRECTORY/./}
    
    done

}



#-------------------------
# CONFIGURATION FUNCTIONS
#-------------------------

get_config_value() {

        # $1-$9 -- name value in config file, and name value to return

        for VAR_NAME_IN_CONFIG in $*; do

            printf -v $VAR_NAME_IN_CONFIG  `cat $PATH_CONFIG | grep -P "^\s*$VAR_NAME_IN_CONFIG" | grep -oP "[^=]+$"`

        done

}



#--------------------
# GIT FUNCTIONS
#--------------------

get_current_branch() {

    # $1 -- name value to return
   
    printf -v $1 "`git branch --show-current`"
}


get_master_branch() {

    # $1 -- name value to return

    VAR_NAME_IN_CONFIG_FILE="GIT_MASTER_BRANCH"

    if [ -z ${!VAR_NAME_IN_CONFIG_FILE} ]; then

        get_config_value ${VAR_NAME_IN_CONFIG_FILE}
    
    fi


    if [ ! -z ${!VAR_NAME_IN_CONFIG_FILE} ] && [ `git branch | grep -oP "\s${!VAR_NAME_IN_CONFIG_FILE}$" -c` -gt 0 ]; then

        printf -v $1 ${!VAR_NAME_IN_CONFIG_FILE} 

    else

        FIRST_COMMIT=`git reflog | tail -1 | grep -oP "^[0-9a-f]+"`
        BRANCH_LIST=`git branch --contains $FIRST_COMMIT | grep -oP "[\w\d-_]+"`

        if [ `echo $BRANCH_LIST | wc -w` = 1 ]; then 
        
            printf -v $1 "$BRANCH_LIST"
        
        else 

            display warning begin
            echo "I do not know what to do! "
            echo "The first commit (#$FIRST_COMMIT) is associated"
            echo "with several branches:"
            echo
            echo "$BRANCH_LIST"
            echo            
            echo "Please enter the name of the master branch"
            echo "in the variable '$VAR_NAME_IN_CONFIG_FILE'"
            echo "in the configuration '$PATH_CONFIG'"
            display warning end

            exit 1
        
        fi

    fi

}

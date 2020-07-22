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
    
    # $1 -- name value to return OR list of allowed parameters
    # $2 -- optional name of the output variable IF the $1 variable contains parameters
    
    # Exemples of use:
    # get_run_mode "NAME_OF_RETURNED_VARIABLE"
    # get_run_mode "delete|mode|action" "NAME_OF_RETURNED_VARIABLE"

    if [ -z "$1" ]; then break; fi


    if [ -z $2 ]; then

        RUN_MODE=`echo "${BASH_ARGV[@]}" | grep -oP "\-{2}[\w\d\-\_]+"`
    
        if [ ! -z "$RUN_MODE" ]; then printf -v $1 ${RUN_MODE:2}; fi

    else 

        RUN_MODE=`echo "${BASH_ARGV[@]}" | grep -oP "\-{2}($1)"`

        if [ ! -z "$RUN_MODE" ]; then printf -v $2 ${RUN_MODE:2}; fi
    
    fi

}


get_run_param() {

    # $1 -- name of the expected parameter AND name value to return parameter value
    # $2 -- optional name of the output variable

    # Exemple of use:
    # get_run_param "--mode"        --> name of returned variable $__MODE
    # get_run_param "--run-test"    --> name of returned variable $__RUN_TEST
    # get_run_param "-p"            --> name of returned variable $_P
    
    # You can use that too:
    # get_run_param "--mode" "MODE" --> name of returned variable $MODE
    # get_run_param "-p" "PARAM"    --> name of returned variable $PARAM
    

    if [ -z "$1" ]; then break; fi


    unset VAR_VALUE

    for (( i=${#BASH_ARGV[@]}; i>=0; i-- )); do

        if [ "${BASH_ARGV[$i]}" = "$1" ]; then

            VAR_VALUE="${BASH_ARGV[$((i-1))]//_/ }"

            break;

        fi

    done

    if [ -z "$2" ]; then 
    
        VAR_NAME="${1//-/_}"
        
        printf -v ${VAR_NAME^^} "$VAR_VALUE"

    else

        printf -v $2 "$VAR_VALUE"

    fi

}


require_source() {

    if [ -z "$1" ]; then break; fi


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

    if [ -z "$1" ]; then break; fi

    
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


prepare_enviroment() {

    # $1 -- name value to return

    for DIRECTORY in $INST_DIRECTORIES; do
        
        require_directory ${DIRECTORY/./}
    
    done

}



#-------------------------
# CONFIGURATION FUNCTIONS
#-------------------------

get_config_value() {

        # $1-$9 -- name value in config file AND name value to return

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

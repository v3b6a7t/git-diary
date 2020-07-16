# ===================================
# SHOW comits with name $1
# ====================================
# $1 -- name to show
# $2 -- remote branch


source "`dirname $0`/utils/display.sh"


GIT_LS_FILES="git ls-files -m -d -o -v --exclude-from=.gitignore $1"

GREP_MAX_COUNT="-m 5"


if [ "_$2_" = "__" ]; then     
    display_info "Branch: '`git rev-parse --abbrev-ref HEAD`', param: '$1'"

    if [ `$GIT_LS_FILES $1 | wc -l` -gt 0 ]; then
        display warning begin
        $GIT_LS_FILES
        display warning end
    fi
else 
    display_info "Remote: '$2', param: '$1'"
fi


display gray begin
git log --oneline $2 | grep $GREP_MAX_COUNT "\[${1^^}:[0-9]*\]"
display gray end

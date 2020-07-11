# ===================================
# SHOW comits with name $1
# ====================================
# $1 -- name to show
# $2 -- remote branch


source "`dirname $0`/utils/display.sh"

if [ "_$2_" = "__" ]
then 
    display_info "Branch: '`git rev-parse --abbrev-ref HEAD`', param: '$1'"

    if [ `git ls-files -m $1 | wc -l` -gt 0 ]
    then
        DISPLAY warning begin
        git ls-files -m -d -o -v $1
        DISPLAY warning end
    fi

else 
    display_info "Remote: '$2', param: '$1'"

fi

DISPLAY gray begin
git log --oneline $2 | grep "\[${1^^}:[0-9]*\]"
DISPLAY gray end
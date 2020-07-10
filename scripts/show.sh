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
        echo -e $DISPLAY_WARNING_BEGIN
        git ls-files -m -d -o -v $1
        echo -e $DISPLAY_WARNING_END
    fi

else 
    display_info "Remote: '$2', param: '$1'"

fi

echo -e $DISPLAY_GRAY_BEGIN
git log --oneline $2 | grep "\[${1^^}:[0-9]*\]"
echo -e $DISPLAY_GRAY_END
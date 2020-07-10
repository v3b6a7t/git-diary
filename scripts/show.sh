# ===================================
# SHOW comits with name $1
# ====================================
# $1 -- name to show
# $2 -- remote branch


echo 

if [ "_$2_" = "__" ]; then
    echo -------------------------------------------
    echo "Branch: '`git rev-parse --abbrev-ref HEAD`', param: '$1'"
    echo -------------------------------------------

    if [ `git ls-files -m $1 | wc -l` -gt 0 ]; then
        git ls-files -m -d -o -v $1
        echo -------------------------------------------
    fi

else 
    echo ----------------------------------------
    echo "Remote: '$2', param: '$1'"
    echo -----------------------------------------

fi

git log --oneline $2 | grep "\[${1^^}:[0-9]*\]"

echo
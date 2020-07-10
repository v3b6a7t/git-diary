# ===================================
# SHOW comits with name $1
# ====================================
# $1 -- name to show
# $2 -- remote branch


info() {
    echo -e "\e[7m $1 \e[27m"
}

echo 

if [ "_$2_" = "__" ]
then 
    info "Branch: '`git rev-parse --abbrev-ref HEAD`', param: '$1'"

    if [ `git ls-files -m $1 | wc -l` -gt 0 ]
    then
        echo
        git ls-files -m -d -o -v $1
    fi

else 
    info "Remote: '$2', param: '$1'"

fi

echo -e "\e[2m"
git log --oneline $2 | grep "\[${1^^}:[0-9]*\]"
echo -e "\e[22m"
echo 

if [ `git ls-files -m $1 | wc -l` -gt 0 ]
then
    echo -------------------------------------------
    git ls-files -m $1
    echo -------------------------------------------
fi

git log --oneline | grep "\[${1^^}:[0-9]*\]"

echo
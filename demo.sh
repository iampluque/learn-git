init-session() {
    git init &> /dev/null
    #wireing: do not take note
    git config alias.adog "log --all --decorate --oneline --graph"  &> /dev/null
    echo "run.sh" > .gitignore
    git add . &> /dev/null
    git commit -am "initial commit" &> /dev/null
}
proceed() {
    echo
    read -p "Press any key to proceed the next step..."
    echo
}

runfile=./sessions/$1.sh

if ! test -f "$runfile"; then
    echo no test case
    return 1
fi

rm -rf demo
mkdir demo

cp $runfile ./demo/run.sh

(cd ./demo && . run.sh)
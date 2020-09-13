init-session() {
    git init &> /dev/null
    #wireing: do not take note
    git config alias.adog "log --all --decorate --oneline --graph"  &> /dev/null
    cat <<EOF > .gitignore
run.sh
config.yml
EOF
    git add . &> /dev/null
    git commit -am "initial commit" &> /dev/null
}
proceed() {
    echo
    read -p "Press any key to proceed the next step..."
    echo
}

runfile=./sessions/$1.yml

if ! test -f "$runfile"; then
    echo no test case
    return 1
fi

rm -rf demo
mkdir demo

cp $runfile ./demo/config.yml

cat <<"EOF" > ./demo/run.sh
echo "$(yq r config.yml intro)"

stepsCount=$(yq r config.yml --length steps)
for (( step = 0; step <= $stepsCount - 1; step++ ))
do  
    proceed

    eval "$(yq r config.yml steps[$step].commands)"

    echo "$(yq r config.yml steps[$step].title) done!"
    echo Current repo state is ...
    git adog
done

echo
echo Session done!
echo
EOF

(cd ./demo && . run.sh)
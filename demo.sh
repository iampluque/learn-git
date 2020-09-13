sessionsDir=./sessions

init_session() {
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
repo_state() {
    echo
    echo Current repo state is ...
    git adog
}
proceed() {
    echo
    read -p "Press any key to proceed the next step..."
    echo
}
list_sessions() {
    for file in $(cd $sessionsDir && ls *.yml)
    do
        echo "  - ${file%%.*}"
    done
}
# get_session() {
#     old="$IFS"
#     IFS='-'
#     echo "$*"
#     IFS=$old
# }
copy_runfile() {
    cat <<"EOF" > $1
echo "$(yq r config.yml intro)"
init_session
repo_state

stepsCount=$(yq r config.yml --length steps)
for (( step = 0; step <= $stepsCount - 1; step++ ))
do  
    proceed

    eval "$(yq r config.yml steps[$step].commands)"
    eval "$(yq r config.yml steps[$step].outputs)"

    echo "$(yq r config.yml steps[$step].title) done!"
    repo_state
done

echo
echo Session done!
echo
EOF
}

session=$1 #$(get_session $@)
configFile=$sessionsDir/$session.yml

if ! test -f "$configFile"; then
    echo Invalid session.
    echo Choose between:

    list_sessions
    return 1
fi

rm -rf demo
mkdir demo

cp $configFile ./demo/config.yml
copy_runfile ./demo/run.sh

(cd ./demo && . run.sh)
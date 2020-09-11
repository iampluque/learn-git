runfile=run-$1.sh

if ! test -f "$runfile"; then
    echo no test case
    return 1
fi

rm -rf demo
mkdir demo

cp run-$1.sh ./demo/run.sh

(cd ./demo && . run.sh)
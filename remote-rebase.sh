echo demo ff-only on origin
read

rm -rf demo
rm -rf anotherUserDemo
rm -rf remote
rm -rf someRebaser

mkdir remote && cd remote
git init --bare
cd ..
mkdir demo && cd demo
git clone ../remote .
touch readme.md
git add .
git commit -am "initial commit"
git push
git adog
read

cd .. && mkdir anotherUserDemo && cd anotherUserDemo/
git clone ../remote .
touch some.file
git add .
git commit -am "some work"
git push
read

cd ../demo
touch my.file
git add .
git commit -am "my work"
git fetch
git pull --ff-only
git adog
read

git rebase origin/master
git adog
git pull --ff-only
read


echo rebase origin et comment s''en sortir

git checkout -b feature
touch feature-1.file
git add .
git commit -am "feature-1"
git push --set-upstream origin feature
read

cd ../anotherUserDemo/
git fetch
git checkout feature
touch feature-2.file
git add .
git commit -am "feature 2"
git push
git adog
read

cd .. && mkdir someRebaser && cd someRebaser/
git clone ../remote/ .
git adog
read

touch file.onmaster
git add .
git commit -am "some file on master"
git push
git checkout feature
git rebase origin/master #-i
git push
git adog 
read

git push -f
read

cd ../demo
git fetch
touch new.file
git add .
git commit -am "some local dev"
git adog
git pull --ff-only
read
git rebase origin/feature #-i
git adog
git pull --ff-only
cd ..
git init &> /dev/null
#wireing: do not take note
git config alias.adog "log --all --decorate --oneline --graph"  &> /dev/null

echo init repo
echo "run.sh" > .gitignore
git add . &> /dev/null
git commit -am "initial commit" &> /dev/null

mastersHead=$(git rev-parse HEAD)
git adog

echo deving feature-1
git checkout -b feature-1 $mastersHead &> /dev/null
echo "Feature 1 Release Notes" >> readme.md
git add . &> /dev/null && git commit -am "modifications from feature 1" &> /dev/null
echo feature-1 done
git adog

echo deving feature-2
git checkout -b feature-2 $mastersHead &> /dev/null
echo "Feature 2 Release Notes" >> readme.md
git add . &> /dev/null && git commit -am "modifications from feature 2" &> /dev/null
echo feature-2 done
git adog

# git checkout -b feature-3 $mastersHead
# echo "Feature 3 Release Notes" >> readme.md
# git add . && git commit -am "modifications from feature 3"

echo merging feature-1
git rebase master &> /dev/null
git checkout master &> /dev/null

git merge feature-1 &> /dev/null
echo feature-1 merged
git adog

echo merging feature-2
git checkout feature-2 &> /dev/null
echo -e "git rebase is currently failing in the following \e[7mwall of text\e[27m"
git rebase master

echo -e "oh no \e[7mgit rebase failed.\e[27m Let's do it manually"
cat << EOF

1. open another console
2. run the following to find conflicts
    
    cd $PWD
    git diff --name-only --diff-filter=U

3. edit your file manually to fix the conflicts and save it (indeed)
4. then, run the following. Most likely win will be the git rebase text editor. Type :wq to write commit comment & exit vim.
    
    git add .
    git rebase --continue

5. when your ready, come back in this console and press any key, will resume the work!
EOF
read

git checkout master &> /dev/null
git merge feature-2 &> /dev/null
echo feature-2 merged

git adog
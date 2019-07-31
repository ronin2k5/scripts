@echo off

REM Syntax: createproject.bat <projectname> <remote git repo url>

REM create folder
mkdir %1
cd %1

REM initialize git
echo. 2> README.md
git init
git add .

REM commit to local respo
git commit -m "Initial commit"

REM link to remote repo using URL, then push committed files to remote repo
git remote add origin %2
git push origin master

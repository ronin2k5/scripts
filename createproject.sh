#!/bin/sh

#Dependencies:
#   -git client should be installed
#   -initprojectdb.sh

#Syntax: createproject.sh <projectname> <remote git repo url>

#create folder
mkdir $1
cd $1

#initialize database files
./initprojectdb.sh $1

#initialize git
touch README.md
git init
git add .

#commit to local respo
git commit -m "Initial commit"

#link to remote repo using URL, then push committed files to remote repo
git remote add origin %2
git push origin master

#!/bin/sh

#Dependencies:
#   -git client should be installed
#   -initprojectdb.sh

#Syntax: createproject.sh <projectname> <remote git repo url>

PROJ_NAME=$1
GIT_URL=$2
CMD_DIR=`pwd`

#create folder
mkdir "$PROJ_NAME"
cd $PROJ_NAME

#initialize database files
"$CMD_DIR/initprojectdb.sh" "$PROJ_NAME"

#initialize git if argument provided
if [ -n "${GIT_URL-unset}" ] 
then
    touch README.md
    git init
    git add .

    #commit to local respo
    git commit -m "Initial commit"

    #link to remote repo using URL, then push committed files to remote repo
    git remote add origin $GIT_URL
    git push origin master
fi

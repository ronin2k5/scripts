#!/bin/zsh

echo Cleaning up any old work files...
source ./resetall.sh

echo Getting list of all available Brews...
source ./listallbrews.sh

echo Getting list of all installed Brews...
source ./listinstalledbrews.sh

echo Updating Port Definitions...
sudo /opt/local/bin/port selfupdate

echo Getting list of active Ports...
source ./listactiveports.sh

echo Initializing database...
source ./initdb.sh

echo Importing data into database...
source ./importlists.sh

echo Exporting cleaned Port list...
source ./exportcleanports.sh

echo Finding Port dependencies...
python port-deps-list.py -f ports-clean.csv

echo Importing Port dependencies...
source ./importportdeps.sh

echo Exporting list of duplicate Ports...
source ./exportduplicateports.sh
dos2unix ports-duplicate.csv

echo Removing duplicate Ports...
source ./removeduplicateports.sh

echo Exporting list of Ports to convert to Brews...
source ./exportport2brew.sh
dos2unix convertport2brew.csv

# echo conerting Ports to Brews...
# source ./convertport2brew.sh

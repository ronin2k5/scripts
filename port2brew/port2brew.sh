#!/bin/zsh

source ./listallbrews.sh
source ./listinstalledbrews.sh
source ./listactiveports.sh
source ./initdb.sh
source ./importlists.sh
source ./exportcleanports.sh
python port-deps-list.py -f ports-clean.csv
source ./importportdeps.sh
source ./exportduplicateports.sh
# source ./removeduplicateports.sh
source ./exportport2brew.sh
# source ./convertport2brew.sh

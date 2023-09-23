#!/bin/zsh

input=ports-duplicate.csv
while IFS= read -r line
do
    echo $line
    sudo /opt/local/bin/port uninstall -q $line
done < $input

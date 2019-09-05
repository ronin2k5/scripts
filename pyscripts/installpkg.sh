#!/bin/sh

pip3 install --user $1

# update requirements.txt
pip3 freeze > requirements.txt

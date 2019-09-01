#!/bin/sh

pip install --user $1

# update requirements.txt
pip freeze > requirements.txt

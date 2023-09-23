#!/bin/sh

python -m pip install --user $1

# update requirements.txt
python -m pip freeze > requirements.txt

@echo off

python -m pip install --user %1

REM update requirements.txt
python -m pip freeze > requirements.txt

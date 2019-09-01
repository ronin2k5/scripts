@echo off

pip install --user %1

REM update requirements.txt
pip freeze > requirements.txt

@echo off

for /f "delims=" %%p in (project.txt) do (
    pushd %%p
    python manage.py runserver
    popd
)

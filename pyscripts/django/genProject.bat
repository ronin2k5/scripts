@echo off

REM python -m pip install --user --upgrade pip

REM python -m pip install virtualenv
REM python -m pip install django
REM python -m pip install django-rest
REM python -m pip install pandas
REM python -m pip install tensorflow

set PROJ=%1
set APP=%2

REM create and activate python virtual environment for project
python -m venv %PROJ%-env

(
    @echo off

    echo Activating virtual environment.
    echo To Deactivate it, type deactivate

    %PROJ%-env\Scripts\activate.bat

) > activate-env.bat

%PROJ%-env\Scripts\activate.bat

REM create project
django-admin startproject %PROJ%

REM create app
pushd %PROJ%
python manage.py startapp %APP%

REM create views
pushd %APP%

ren views.py views.py.orig

(
    echo from django.shortcuts import render
    echo from django.http import HttpResponse
    echo.
    echo def index^(request^):
    echo     return HttpResponse^("Hello, world. You're at the %APP% index."^)
) > views.py

REM generate data model
ren models.py models.py.orig
python ../../genModels.py ../../model.txt

popd

REM initialize database
python manage.py makemigrations
python manage.py migrate

REM add URLs
pushd %PROJ%

(
    echo.
    echo from %APP% import views
    echo.
    echo urlpatterns.append^(path^('', views.index, name='index'^)^)
) >> urls.py

popd

popd

REM create cleanup script
(
    @echo off

    call cleanup.bat foresight

) > resetproject.bat

echo %PROJ% > project.txt

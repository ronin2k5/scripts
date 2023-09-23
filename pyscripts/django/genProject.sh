#!/bin/sh

# python -m pip install virtualenv
# python -m pip install django
# python -m pip install django-rest
# python -m pip install pandas
# python -m pip install tensorflow

PROJ=$1
APP=$2

# create and activate python virtual environment for project
python -m venv $PROJ-env

(
    #!/bin/sh

    echo Activating virtual environment.
    echo To Deactivate it, type deactivate

    $PROJ-env/bin/activate

) > activate-env.sh

source $PROJ-env/bin/activate

# create project
django-admin startproject $PROJ

# create app
pushd $PROJ
python manage.py startapp $APP

# create views
pushd $APP

mv views.py views.py.orig

(
    echo from django.shortcuts import render
    echo from django.http import HttpResponse
    echo.
    echo def index(request):
    echo     return HttpResponse^("Hello, world. You're at the $APP index."^)
) > views.py

popd

# add URLs
pushd $PROJ

(
    echo.
    echo from $APP import views
    echo.
    echo urlpatterns.append^(path^('', views.index, name='index'^)^)
) >> urls.py

popd

popd

echo $PROJ > project.txt

@echo off

set PROJ=%1

IF [%PROJ%]==[] (
    echo Syntax: %0 PROJECT
    goto:EOF
)

REM del /s %PROJ%\*
rmdir /q /s %PROJ%
del /q project.txt

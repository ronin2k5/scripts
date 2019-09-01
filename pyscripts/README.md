# pyscript

These scripts should be saved in a place where they can be accessed globally.

When using them, be sure to call them from the project folder.

## getreqs.bat / getreqs.sh
- gets all dependencies in the requirements.txt file

## installpkg.bat / installpkg.sh
- installs the package passed in and automatically updates requirements.txt

## pkginfo.bat / pkginfo.sh
- gets information about the package passed in

## savereqs.bat / savereqs.sh
- save all requirements into requirements.txt
- run this to refresh the requirements.txt file any time new dependencies are added or if getreqs.bat begins returning errors

## upgradepip.bat / upgradepip.sh
- upgrade pip to the latest version

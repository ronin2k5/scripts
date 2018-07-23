#!/bin/sh

#XCode
echo ==================================Installing XCode Updates=================
xcode-select --install
#may need to run the following after new xcode-select installs
#sudo xcodebuild -license
#sudo xcodebuild -license accept

#mac ports
echo ==================================Installing MacPorts Updates=============
echo ----------------------------------Updating Mac Ports----------------------
sudo port -v selfupdate
echo ----------------------------------Installing Updates----------------------
#command to get list of outdated ports
#sudo port outdated | awk '{print $1;}

sudo port upgrade outdated

#cleanup
sudo port -f clean --all all
sudo port -f uninstall inactive
sudo rm -rf /opt/local/var/macports/build/*
sudo rm -rf /opt/local/var/macports/distfiles/*
sudo rm -rf /opt/local/var/macports/packages/*

#command to check which macports are installed
#port installed

#command to remove a macports package
#sudo port uninstall --follow-dependencies <portname>

#homebrew
echo ==================================Installing Homebrew Updates=============
echo ----------------------------------Updating Repository List----------------
brew update
echo ----------------------------------Installing Updates----------------------
brew upgrade

#homebrew cask
#echo ----------------------------------Installing Homebrew Cask Updates--------
#the below command should upgrade all hombrew casks
#however, it is commented as I believe it will just force a reinstall of all casks
#even if there is no upgrade...some casks like the CUDA drivers are very large (~1 GB)
#brew cask list | xargs brew cask install --force

#list all outdated brews
#brew outdated

#remove a homebrew package
#brew remove <packagename>

#cleanup old homebrew packages
#brew cleanup

#check for brew issues
#brew doctor

#-----------------------------------Troubleshooting-----------------------------
#Error: The `<package> link` step did not complete successfully
#The formula built, but is not symlinked into <directory>
#Could not symlink <directory>/<package>
#<full directory path> is not writable.
#
#Solution:
#sudo chown -R `whoami`:admin <full directory path>
#brew link <package>

#gem
echo ==================================Installing Gem Updates==================
echo ----------------------------------Updating RubyGems System----------------
sudo gem update --system
echo ----------------------------------Installing Updates----------------------
#list outdated gems
#sudo gem outdated

sudo gem update

#node package manager
echo ==================================Installing Node Updates=================

#if npm breaks, try the following:
#sudo rm -rf /usr/local/lib/node_modules/npm
#brew reinstall node

echo ----------------------------------Updating NPM----------------------------
sudo npm install -g npm@latest
#sudo npm i -g npm
echo ----------------------------------Installing Updates----------------------
#list outdated packages
#sudo npm outdated

sudo npm update -g

#pip - PyPi Python 3 Package Installer
echo ==================================Installing Pip Updates==================
echo ----------------------------------Update PIP------------------------------
sudo -H pip3 install --upgrade pip
echo ----------------------------------Installing Updates----------------------
#list outdated packages
#pip3 list --outdated

#sudo -H pip3 freeze > requirements.txt
#sudo -H pip3 list --outdated  | awk '{print $1;}' > requirements.txt
sudo -H pip3 list --outdated  | awk '{printf "%s",$1;printf "==";print $3}' > temp.txt; sed '1d' temp.txt > temp2.txt;sed '1d' temp2.txt > requirements.txt
sudo -H pip3 install --upgrade -r requirements.txt
rm temp.txt
rm temp2.txt
rm requirements.txt

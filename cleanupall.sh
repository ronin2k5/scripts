#!/bin/zsh

# In mac os 10.15+, the terminal can't access certain folders
# You can grant full disk access by:
# Launching Preferences
# Going to Security & Privacy
# Go to the Privacy Tab
# In the left pane, scroll down to Full Disk Access and select it
# In the bottom of the window, click the lock icon and enter your password
# In the righ pane, press the + button and select whichever terminal app you like to use
# Remenber to relock the security settings by clicking the lock icon
# You must restart the terminal app for changes to take effect

# check existing disk usage
echo Usage before cleaning:
df -h

# user log files
sudo rm -rf ~/Library/Logs/*

# mail conneciton logs
rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Logs/*

# echo "Delete Mail Connection Logs:"
# echo "Open Finder and go to ~/Library/Containers/com.apple.mail/Data/Library/Logs"
# echo "Delete all the contents of this folder"
# echo ""
# echo "To disable Mail connection logs permanently:"
# echo "Launch Mail"
# echo "Under the Window menu, click 'Connection Doctor'"
# echo "Uncheck 'Log Connection Activity'"

#user cache files
sudo rm -rf ~/Library/Caches/*

#ununsed disk images

#old updates
sudo rm -rf -R ~/Library/Application Support/Java/*

#language files
ls -d /Applications/*.app/Contents/Resources/*.lproj | grep -i -v '/Resources/en.*\.lproj' | grep -i -v '/Resources/base.*\.lproj' > deletefiles.txt

for f in $(cat deletefiles.txt) ; do 
  sudo rm -R -rf "$f"
  echo -n "."
done

echo "."
rm -rf deletefiles.txt

#system log files
sudo rm -rf /Library/Logs/*
sudo rm -rf /private/var/db/diagnostics/*
sudo rm -rf /private/var/log/*

#downloads

#Xcode junk

#system cache files

#broken login items

#deleted users

#document versions

#broken preferences

#mail attachments

#trash bins

# check disk usage after cleaning
echo Usage after cleaning:
df -h

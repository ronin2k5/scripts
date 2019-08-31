#!/bin/sh

#run D-Bus
sudo launchctl load -w /Library/LaunchDaemons/org.freedesktop.dbus-system.plist
launchctl load -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist

#launch app
wine $1

#!/bin/sh

ps aux | head -n1
ps aux | grep -i $1 | grep -v grep | grep -v findproc.sh

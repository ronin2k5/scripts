#!/bin/zsh

# scipt to determine which process has a file locked and preventing it from being deleted
# syntax ./whatskeepingme.sh <path to file>

lsof $1

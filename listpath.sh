#!/bin/sh

echo $PATH|sed 's/:/\'$'\n/g'

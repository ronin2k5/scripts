#!/bin/sh

#create folders
mkdir db
cd db

mkdir ddl
mkdir dml

#create script files
cd ddl
echo '#drop database $1;' > database.sql
echo 'create database $1;' >> database.sql

touch tabes.sql
touch views.sql

#!/bin/sh

# this will take an infoshopkeeper DB dump and 
# import it into Borges.
#
# usage: ./upgrade_infoshopkeeper.sh infoshop_db.sql

# production: app is in ~/borges
# dev: app is in /vagrant
if [ -f ~/borges ]
then
    cd ~/borges
else
    cd /vagrant
fi

echo "configuring infoshopkeeper database"
echo "create user 'isk@localhost' identified by 'isk'" | mysql -u root -p
echo "create database isk" | mysql -u root -p
echo "grant all privileges on isk.* to isk identified by 'isk'" | mysql -u root -p

git checkout 8a33fbe

# we need some dependencies for old gems
sudo apt-get install -y libxml2-dev libxslt1-dev libpq-dev
bundle install

echo "importing infoshop db dump"
mysql -u isk -p -h localhost isk < $1

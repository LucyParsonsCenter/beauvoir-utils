#!/bin/sh

# this will take an infoshopkeeper DB dump and 
# import it into Beauvoir
#
# usage: ./upgrade_infoshopkeeper.sh infoshop_db.sql

# production: app is in ~/beauvoir
# dev: app is in /vagrant
if [ -f ~/beauvoir ]
then
    cd ~/beauvoir
else
    cd /vagrant
fi

echo "configuring infoshopkeeper database"
echo "type in the mysql root password 3x"
echo "create user 'isk@localhost' identified by 'isk'" | mysql -u root -p
echo "create database isk" | mysql -u root -p
echo "grant all privileges on isk.* to isk identified by 'isk'" | mysql -u root -p
echo "importing infoshop db dump"
echo "type in 'isk' for this one!"
mysql -u isk -p -h localhost isk < $1

bundle exec rake infoshopkeeper:import

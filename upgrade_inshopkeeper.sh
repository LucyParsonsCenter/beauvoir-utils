#!/bin/sh

# this will take an infoshopkeeper DB dump and 
# import it into Borges.

if [ -f ~/borges ]
then
    cd ~/borges
else
    cd /vagrant
fi

echo "configuring infoshopkeeper database"
echo "create user 'isk@localhost' identified by 'isk'" | mysql -u root -p
echo "create database idk" | mysql -u root -p
echo "grant all privileges on isk.* to isk identified by 'isk'" | mysql -u root -p


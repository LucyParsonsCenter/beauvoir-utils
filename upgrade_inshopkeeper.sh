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

CURRENT = git log --pretty=format:"%d" -1

echo $CURRENT

git checkout 8a33fbe

# we need some dependencies for old gems
sudo apt-get install -y libxml2-dev libxslt1-dev libpq-dev ruby1.9.1
sudo gem install bundler
sudo gem install rake -v '10.0.4'
echo "gem 'activerecord-mysql2-adapter'" >> Gemfile
bundle install

echo "importing infoshop db dump"
mysql -u isk -p -h localhost isk < $1

echo "deleting new Borges db schema"
echo "drop database borgesdev" | mysql -u root -p
echo "drop database borgestest" | mysql -u root -p
echo "drop database borgesprod" | mysql -u root -p

echo "rebuilding the old-school db schema"
echo "create database borgesdev" | mysql -u root -p
echo "create database borgestest" | mysql -u root -p
echo "create database borgesprod" | mysql -u root -p
echo "grant all privileges on borgesdev.* to borges identified by 'password'" | mysql -u root -p
echo "grant all privileges on borgestest.* to borges identified by 'password'" | mysql -u root -p
echo "grant all privileges on borgesprod.* to borges identified by 'password'" | mysql -u root -p
 
bundle exec rake db:schema:load
bundle exec rake infoshopkeeper:import

# rm Gemfile Gemfile.lock
# git checkout $CURRENT

# bundle exec db:migrate

# # then run db:migrate

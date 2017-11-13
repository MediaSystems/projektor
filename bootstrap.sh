#!/usr/bin/env bash

Update () {
    echo "-- Update packages --"
    sudo apt-get update
    sudo apt-get upgrade
}
Update

sudo -i export DEBIAN_FRONTEND="noninteractive"
#echo "-- Prepare configuration for MySQL --"
#sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
#sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
#sudo debconf-set-selections <<< "mariadb-server-10.1 mysql-server/root_password password root"
#sudo debconf-set-selections <<< "mariadb-server-10.1 mysql-server/root_again_password password root"

echo "-- Install tools and helpers --"
sudo apt-get install -y software-properties-common vim htop curl git git-core


echo "-- Install packages --"
sudo apt-get install -y graphicsmagick nginx mongodb

echo "-- Enable Services --"
sudo systemctl enable mongodb

MONGO_URL='mongodb://localhost/meteor'
export MONGO_URL

curl https://install.meteor.com/ | sh


cd /vagrant

meteor npm install -g mgp
meteor mgp --https
meteor npm install
#meteor npm install --save bcrypt

echo "...done!";
echo "Starting Meteor Webserver: http://192.168.100.100:3000";
echo "...it takes it time to get Meteor UP...please be patient";
meteor

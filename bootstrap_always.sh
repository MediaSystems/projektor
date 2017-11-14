#!/usr/bin/env bash

MONGO_URL='mongodb://localhost/meteor'
export MONGO_URL
cd /vagrant
echo "Starting Meteor Webserver: http://192.168.100.100:3000";
echo "...it takes it time to get Meteor UP...please be patient";
meteor > /dev/null 2>&1 &
echo "...done!";

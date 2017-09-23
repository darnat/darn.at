#!/usr/bin/env sh

while true
do
    rails s -p 3000 -b '0.0.0.0'
    sleep 1
done
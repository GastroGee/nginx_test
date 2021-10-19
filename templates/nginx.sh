#!/bin/env bash 
## i am  assuming that the EC2 image is ubuntu
## variables

s3_bucket=${s3_bucket}

sudo apt-get update

sudo apt-get install nginx

sudo wget -O ${s3_bucket}/web.conf /etc/nginx/sites-available/web.conf

sudo ln -ls /etc/nginx/sites-available/web.conf /etc/nginx/sites-enabled/web.conf

sudo wget -O ${s3_bucket}/index.html /usr/share/nginx/html/index.html

sudo service nginx restart
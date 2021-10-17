#!/bin/env bash 
## i am  assuming that the EC2 image is ubuntu
## variables
nginx_version=${nginx_version}
s3_bucket=${s3_bucket}

sudo apt-get update

sudo apt-get install nginx==${nginx_version}

sudo wget -o ${s3_bucket}/web.conf /etc/nginx/sites-available/web.conf

sudo ln -ls /etc/nginx/sites-available/web.conf /etc/nginx/sites-enabled/web.conf

sudo service nginx restart
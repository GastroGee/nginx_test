#!/bin/env bash 
## i am  assuming that the EC2 image is ubuntu
## variables


sudo apt-get update

sudo apt-get -y install nginx

echo "updating default root html file for nginx"
sudo tee /var/www/html/index.nginx-debian.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
<head>
<title>Hello World!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1> Hello World </h1></h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
EOF


sudo service nginx restart
#!/bin/bash

# Install required packages
apt-get update -y
apt-get install -y sudo mariadb-server

# Configure mariadb
service mysql stop
mysql_install_db
'/usr/bin/mysqladmin' -u root password 'password'
service mysql start
(echo "password"; echo "n"; echo "n"; echo "n"; echo "n"; echo "n";) | mysql_secure_installation

# Create and login as new user
adduser --system --home /home/donate --disabled-password --shell /bin/bash donate
(echo "password"; echo "password"; ) | passwd donate
sudo usermod -aG sudo donate
sudo su - donate
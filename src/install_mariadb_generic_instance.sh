#!/bin/bash

# Install required packages
sudo apt-get update -y
sudo apt-get install -y sudo mariadb-server

# Configure mariadb
sudo service mysql stop
sudo mysql_install_db
sudo '/usr/bin/mysqladmin' -u root password 'password'
sudo service mysql start
(echo "password"; echo "n"; echo "n"; echo "n"; echo "n"; echo "n";) | sudo mysql_secure_installation

# Create and login as new user
sudo adduser --system --home /home/user --disabled-password --shell /bin/bash user
(echo "password"; echo "password"; ) | sudo passwd user
sudo usermod -aG sudo user
sudo su - user

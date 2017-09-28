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
sudo adduser --system --home /home/donate --disabled-password --shell /bin/bash donate
(echo "password"; echo "password"; ) | sudo passwd donate
sudo usermod -aG sudo donate
sudo su - donate
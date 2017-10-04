#!/bin/bash

# Install required packages
apt-get install -y sudo software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.coreix.net/mariadb/repo/10.2/ubuntu xenial main'
apt-get update -y
apt-get install -y sudo mariadb-galera-server galera-arbitrator-3

# Configure mariadb
#service mysql stop
#mysql_install_db
#'/usr/bin/mysqladmin' -u root password 'password'
#service mysql start
#(echo "password"; echo "n"; echo "n"; echo "n"; echo "n"; echo "n";) | mysql_secure_installation

# Create and login as new user
adduser --system --home /home/donate --disabled-password --shell /bin/bash donate
(echo "password"; echo "password"; ) | passwd donate
usermod -aG sudo donate
su - donate
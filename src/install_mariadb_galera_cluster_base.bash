#!/bin/bash

# Get config data
cd .. & source $PWD/setup.cnf
cd src

# Get basic packages 
sudo apt-get update -y
sudo apt-get install -y nano git software-properties-common rsync sudo ufw expect

# Install most recent version of mariadb-server
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu xenial main';#'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu xenial main'
sudo apt-get update
# sudo apt-get install -y mariadb-server
expect -c "
spawn sudo apt-get install -y mariadb-server
set timeout = 60
expect -nocase \"*New password for the MariaDB \"root\" user:*\" {send \"$mysql_password\r\"; interact}
expect -nocase \"*Repeat password for the MariaDB \"root\" user:*\" {send \"$mysql_password; interact}
"

# Copy galera config
sudo cp $PWD/galera.cnf /etc/mysql/conf.d/galera.cnf

# Setup galera firewalls exceptions (including SSH and workbench)
expect -c "
spawn sudo ufw enable
expect -nocase \"Command may disrupt existing ssh connections. Proceed with operation (y|n)?\" {send \"y\r\"; interact}
"
sudo ufw allow 3306,4444,4567,4568/tcp
sudo ufw allow 4567/udp
sudo ufw allow 22/tcp
sudo ufw status

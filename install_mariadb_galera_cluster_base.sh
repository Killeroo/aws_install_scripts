#!/bin/bash
# Install prerequisuite packages for a active-passive galera cluster

# Arguments check
if [ $# -eq 0 ]; then
	echo "Please specify node number";
	exit;
fi

# Get basic packages 
apt-get update -y
apt-get install -y nano git software-properties-common rsync sudo

# Install most recent version of mariadb-server
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu xenial main'
apt-get update
apt-get install -y mariadb-server

# Create account and login
user="galera-node-$1"
adduser --system --home /home/$user --disabled-password --shell /bin/bash $user
(echo "password"; echo "password"; ) | passwd $user
usermod -aG sudo $user
su - $user
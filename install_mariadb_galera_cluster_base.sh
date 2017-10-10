#!/bin/bash
# Install prerequisuite packages for a active-passive galera cluster

# Arguments check
if [ $# -lt 2 ]; then
	echo "Not enough arguments: script [node_num] [node_ip]";
	exit;
else
	user="galera-node-$1"
	node_ip=$2
fi

# Get basic packages 
apt-get update -y
apt-get install -y nano git software-properties-common rsync sudo ufw

# Install most recent version of mariadb-server
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu xenial main';#'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu xenial main'
apt-get update
apt-get install -y mariadb-server

# Copy and update galera config
mv ./galera.cnf /etc/mysql/conf.d/galera.cnf
echo "wsrep_node_address=\"$node_ip\"" >> /etc/mysql/conf.d/galera.cnf
echo "wsrep_node_name=\"$user\"" >> /etc/mysql/conf.d/galera.cnf
echo "wsrep_cluster_address=\"gcomm://first_ip,second_ip,third_ip\"" >> /etc/mysql/conf.d/galera.cnf

# Setup galera firewalls exceptions (and SSH and )
ufw enable
ufw allow 3306,4444,4567,4568/tcp
ufw allow 4567/udp
ufw allow 22/tcp
ufw status

echo
echo "#####################################################################################";
echo "**REMEMBER TO REPLACE wsrep_cluster_address=\"gcomm://first_ip,second_ip,third_ip\"**";
echo "  In /etc/mysql/conf.d/galera.cnf"
echo "#####################################################################################";

# Create account and login
adduser --system --home /home/$user --disabled-password --shell /bin/bash $user
(echo "password"; echo "password"; ) | passwd $user
usermod -aG sudo $user
su - $user
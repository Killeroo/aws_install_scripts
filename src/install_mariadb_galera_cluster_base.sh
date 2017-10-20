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
sudo apt-get update -y
sudo apt-get install -y nano git software-properties-common rsync sudo ufw expect

# Install most recent version of mariadb-server
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu xenial main';#'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu xenial main'
sudo apt-get update
sudo apt-get install -y mariadb-server

# Copy and update galera config
sudo cp ./galera.cnf /etc/mysql/conf.d/galera.cnf
echo "wsrep_node_address=\"$node_ip\"" >> /etc/mysql/conf.d/galera.cnf
echo "wsrep_node_name=\"$user\"" >> /etc/mysql/conf.d/galera.cnf
echo "wsrep_cluster_address=\"gcomm://1.1.1.1,2.2.2.2,3.3.3.3\"" >> /etc/mysql/conf.d/galera.cnf

# Setup galera firewalls exceptions (including SSH and workbench)
sudo ufw enable
sudo ufw allow 3306,4444,4567,4568/tcp
sudo ufw allow 4567/udp
sudo ufw allow 22/tcp
sudo ufw status

echo
echo "###########################################################################";
echo "                      **REMEMBER TO REPLACE**"
echo "wsrep_cluster_address=\"gcomm://\" @ /etc/mysql/conf.d/galera.cnf"
echo
echo "                  OR run 'setup_galera_config.sh'"
echo "###########################################################################";
echo

# Create account and login
sudo adduser --system --home /home/$user --disabled-password --shell /bin/bash $user
(echo "password"; echo "password"; ) | sudo passwd $user
sudo usermod -aG sudo $user
#sudo su - $user
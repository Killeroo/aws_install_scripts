#!/bin/bash

echo 
echo "####################WARNING#######################"
echo "  Run script with 'bash setup_galera_config.sh'"
echo "               AND run as root"
echo "###################################################"
echo 

# Check script is running as root
if [[ $EUID -ne 0 ]]; then
	echo "Please run script as root"
	exit;
fi

# Argument check 
if [ $# -lt 3 ]; then
	echo -n "Enter galera_node_1 ip: ";
	read node_1_ip
	echo -n "Enter galera_node_2 ip: ";
	read node_2_ip
	echo -n "Enter galera_node_3 ip: ";
	read node_3_ip
else
	node_1_ip=$1
	node_2_ip=$2
	node_3_ip=$3
fi

# Check file exists
if [ ! -f /etc/mysql/conf.d/galera.cnf ]; then
	echo 
	echo "      ******Galera config file not found********"
	echo "Run install_mariadb_galera_cluster_base.sh and try again"
	echo
	exit;
fi

# Update config
sudo echo "wsrep_cluster_address=\"gcomm://$node_1_ip,$node_2_ip,$node_3_ip\"" >> /etc/mysql/conf.d/galera.cnf

echo "##### CONFIG UPDATED WITH NODE ADDRESSES #####";
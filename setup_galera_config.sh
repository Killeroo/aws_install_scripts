#!/bin/bash

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
sudo echo "wsrep_cluster_address=\"gcomm://first_ip,second_ip,third_ip\"" >> /etc/mysql/conf.d/galera.cnf

echo "##### CONFIG UPDATED WITH NODE ADDRESSES #####";
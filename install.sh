#!/bin/bash

# Arguments check
if [ $# -ne 3 ]; then
	echo "Not enough arguments:"
	echo "Usage: main [node_num] [node_ip] [cluster_ips] (formatted: 1.1.1.1,2.2.2.2,3.3.3.3)"
	exit
fi

# Interupter check
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "Please use 'bash main.sh to run the script"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "Please run script as root"
	exit;
fi

# Run scripts

sudo bash ./src/install_mariadb_galera_cluster_base.sh $1 $2 # Base install
sudo bash ./src/update_galera_config.sh $3 # Update cluster 
read -r -p "Setting up main node? [Y/n] " response
case "$response" in 
	[yY][eE][sS]|[yY])
		sudo bash ./src/start_galera_cluster.sh
		;;
	*)
		sudo bash ./src/start_galera_node.sh
		;;
esac
sudo bash ./src/show_galera_status.sh

echo "Installation complete. Galera is now running on this machine"
echo "Signing into account..."

sudo su - $user
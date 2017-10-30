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

# Check password exists in passwords.conf
password=$(bash $PWD/src/fetch_password.sh account)
if [[ -z "${password// }" ]]; then
	echo "***NO ACCOUNT PASSWORD FOUND IN PASSWORDS.CONF***"
	echo "Please ensure a password is entered in passwords.conf and try again"
	exit
fi

# Run scripts
cd src/
sudo bash ./install_mariadb_galera_cluster_base.sh $1 $2 
read -r -p "Would you like to install new-relic? [Y/n] " response
case "$response" in 
	[yY][eE][sS]|[yY])
		sudo bash ./install_new-relic.sh
		;;
	*)
		;;
esac
read -r -p "Would you like to add support for MySQL Workbench? [Y/n] " response
case "$response" in 
	[yY][eE][sS]|[yY])
		sudo bash ./add_workbench_support.sh
		;;
	*)
		;;
esac
sudo bash ./update_galera_config.sh $3 
read -r -p "Setting up main node? [Y/n] " response
case "$response" in 
	[yY][eE][sS]|[yY])
		sudo bash ./enable_node_bootstrapping.sh
		sudo bash ./start_galera_cluster.sh
		;;
	*)
		sudo bash ./start_galera_node.sh
		;;
esac
sudo systemctl --no-pager --lines=0 status mysql
cd ..

echo
echo "Installation complete. Galera is now running on this machine"
echo "Signing into account..."

# Sign new user in
user="galera-node-$1"
sudo su - $user
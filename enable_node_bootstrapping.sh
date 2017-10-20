#!/bin/bash

# Check if script is being run with bash
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "Please use 'bash enable_node_bootstrapping.sh to run the script"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "Please run script as root"
	exit;
fi

echo
echo "###########################################################################";
echo "                         ***WARNING***"
echo "          ONLY RUN THIS SCRIPT ON THE MAIN CLUSTER NODE"
echo " (It enables starting node even if it was not the last node to exit cluster)"
echo "###########################################################################";
echo 

read -r -p "Continue? [Y/n] " response
case "$response" in 
	[yY][eE][sS]|[yY])
		;;
	*)
		exit;
		;;
esac

echo "here"
exit

# Check file exists
if [ ! -f /etc/mysql/conf.d/galera.cnf ]; then
	echo "      ******Galera config file not found********"
	echo "Run install_mariadb_galera_cluster_base.sh and try again"
	echo
	exit;
fi

sed -i "s|wsrep_cluster_address=.*|wsrep_cluster_address=\"gcomm://$1\"|" /etc/mysql/conf.d/galera.cnf
echo "Updated safe_to_bootstrap -> 1"
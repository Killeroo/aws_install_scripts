#!/bin/bash

read -r -p "Are you starting up the main Galera node? [Y/n] " response
case "$response" in 
	[yY][eE][sS]|[yY])
		sudo bash ./src/start_galera_cluster.sh
		;;
	*)
		sudo bash ./src/start_galera_node.sh
		;;
esac
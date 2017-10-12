#!/bin/bash
# Updates an existing galera config file with new node data

function update-cluster-addresses {
	sed -i "s/wsrep_cluster_address=.*/wsrep_cluster_address=\"gcomm://$1\"/" /etc/mysql/conf.d/galera.cnf
	echo "Updated galera_cluster_address -> $1"
}

function update-new-ip {
	sed -i "s/wsrep_node_address=.*/wsrep_node_address=\"$1\"/" /etc/mysql/conf.d/galera.cnf
	echo "Updated galera_node_address -> $1"
}

echo 
echo "####################WARNING#######################"
echo "  Run script with 'bash setup_galera_config.sh'"
echo "               AND run as root"
echo "###################################################"
echo 

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "Please run script as root"
	exit;
fi

# Check config file exists
if [ ! -f /etc/mysql/conf.d/galera.cnf ]; then
	echo "      ******Galera config file not found********"
	echo "Run install_mariadb_galera_cluster_base.sh and try again"
	echo
	exit;
fi

# Arguments check
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
	echo "Not enough arguments: script [cluster_ips] [new_ip](optional)";
	echo "(NOTE)[cluster_ips] should be formated: 1.1.1.1,2.2.2.2,3.3.3.3";
	exit;
else
	# Config update
	if [ $# -eq 1 ]; then
		update-cluster-addresses $1
	else
		update-cluster-addresses $1
		update-new-ip $2
	fi
fi
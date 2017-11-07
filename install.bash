#!/bin/bash

# Interupter check
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@     PLEASE RUN SCRIPT WITH BASH!      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@       PLEASE RUN SCRIPT AS ROOT!      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

echo "-> Starting installation"

# Check config file
config_status=$(bash check_config_file.bash)
if [ $config_status -eq 1 ]; then
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@          SETUP.CNF NOT FOUND!         @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "Please ensure this file exists @ $PWD"
    echo "then try again."
    exit
elif [ $config_status -eq 2 ]; then
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@          SETUP.CNF IS EMPTY!          @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "Please enter details into $PWD/setup.cnf"
    echo "then try again."
    exit;
fi
echo "-> Config file good"
source $PWD/setup.cnf

# Navigate to script directory
cd src/

echo "-> Preinstallation setup..."
sudo bash ./setup_debconf.bash $mysql_password
echo "-> Installing base packages..."
address=$(ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1) # Get local ip
sudo bash ./install_mariadb_galera_cluster_base.bash
echo "-> Updating Galera config..."
sudo bash ./update_galera_config.bash wsrep_cluster_name $galera_cluster_name
sudo bash ./update_galera_config.bash wsrep_cluster_address "gcomm://$galera_cluster_addresses"
sudo bash ./update_galera_config.bash wsrep_node_address $address
sudo bash ./update_galera_config.bash wsrep_node_name $galera_node_name
echo "-> Installing new-relic..."
sudo bash ./install_new-relic.bash
echo "-> Adding support for MySQL Workbench..."
sudo bash ./add_workbench_support.bash
echo "-> Creating account..."
sudo bash ./create_account.bash

# Navigate back
cd ..

echo
echo "-> Installation complete."
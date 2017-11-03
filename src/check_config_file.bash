#!/bin/bash
# checks integrity of config file
# Based off: http://wiki.bash-hackers.org/howto/conffile

confi_dir=$(dirname $PWD)

# Check config file exists
if [ ! -f $config_dir/setup.cnf ]; then
	echo 1
	exit;
fi

# Check key fields arent empty
source $config_dir/setup.cnf
if [ -z $account_name ]; then
    echo 2 && exit;
elif [ -z $account_password ]; then
    echo 2 && exit;
elif [ -z $mysql_password ]; then
    echo 2 && exit;
elif [ -z $galera_cluster_name ]; then
    echo 2 && exit;
elif [ -z $galera_node_name ]; then
    echo 2 && exit;
elif [ -z $galera_cluster_addresses ]; then
    echo 2 && exit;
fi

# config file is good
echo 0;
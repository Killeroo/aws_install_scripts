#!/bin/bash

# Arguments check
if [ $# -ne 1 ]; then
	echo "Incorrect argument count:"
	echo "fetch_password [mysql] OR [account] OR [new-relic]"
	exit
fi

# Get the r
org_dir=$(dirname $PWD)
echo $org_dir
read

# Check password.conf exists
if [ ! -f $PWD/password.conf ]; then
	echo "***password.conf file could not be found***"
	echo "Please ensure this file exists in $PWD and try again"
	exit;
fi

# Fetch appropriate password
if [ "$1" == "mysql" ]; then
	grep 'mysql_password=' $PWD/passwords.conf | awk -F= '{ print  $2 }'
elif [ "$1" == "account" ]; then
	grep 'account_password=' $PWD/passwords.conf | awk -F= '{ print  $2 }'
elif
	grep 'new-relic_key=' $PWD/passwords.conf | awk -F= '{ print  $2 }'
else
	echo "Unrecognised argument: Please use either [mysql] OR [account]"
fi
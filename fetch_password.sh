#!/bin/bash

# Takes mysql or account argument

# Check if script is being run with bash
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "Please use 'bash fetch_password.sh to run the script"
	exit;
fi

# Arguments check
if [ $# -ne 1 ]; then
	echo "Incorrect argument count:"
	echo "fetch_password [mysql] OR [account]"
	exit
fi

# Check password.conf exists
if [ ! -f $PWD/password.conf ]; then
	echo "***password.conf file could not be found***"
	echo "Please ensure this file exists in $PWD and try again"
	exit;
fi

# Check password.conf passwords is not empty

if [ "$1" == "mysql" ]; then
	grep 'mysql_password=' $PWD/password.conf | awk -F= '{ print  $2 }'
elif [ "$1" == "account" ]; then
	grep 'account_password=' $PWD/password.conf | awk -F= '{ print  $2 }'
else
	echo "Unrecognised argument: Please use either [mysql] OR [account]"
fi

# Fetch password from conf file
grep 'password=' $PWD/password.conf | awk -F= '{ print  $2 }'
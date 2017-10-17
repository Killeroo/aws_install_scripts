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
	echo "fetch_password [mysql] OR [general]"
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
	echo "fine"
fi

if [ "$1" == "general"]; then
	echo "also fine"
else
	echo "i dont know that"
fi

# Fetch password from conf file
grep 'password=' $PWD/password.conf | awk -F= '{ print  $2 }'
#!/bin/bash

# Check if script is being run with bash
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "Please use 'bash fetch_password.sh to run the script"
	exit;
fi

echo "root check"
sudo bash ./check_root.sh

echo "some more stuff is happening here that should not be happening"
#!/bin/bash

# Interupter check
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "Please use 'bash tests.sh to run the script"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "Please run script as root"
	exit;
fi

sudo bash ./src/create_test_data.sh
sudo bash ./src/view_test_data.sh

read -r -p "Would you like to remove test data? [Y/n] " response
case "$response" in 
	[yY][eE][sS]|[yY])
		sudo bash ./src/remove_test_data.sh
		;;
	*)
		;;
esac

echo "Test complete."
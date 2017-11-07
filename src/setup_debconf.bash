#!/bin/bash

# Pre sets mysql password so we are not prompted during installation

# Arguments check
if [ $# -ne 1 ]; then
	echo "USAGE: setup_debconf.bash [ password ]";
	exit;
fi

# Turn off front end prompts
export DEBIAN_FRONTEND="noninteractive"

# Preset password [https://serversforhackers.com/c/installing-mysql-with-debconf]
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $1"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $1"

echo "> Done."
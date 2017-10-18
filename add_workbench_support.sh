#!/bin/bash

# Adds the required ssh config lines to let mysql workbench ssh 
# into the instance
# Based on: https://serverfault.com/a/692131

# Check if script is being run with bash
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "Please use 'bash update_galera_config.sh to run the script"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "Please run script as root"
	exit;
fi

# Check config file exists
if [ ! -f /etc/ssh/sshd_config ]; then
	echo "      ******SSH config file not found********"
	echo "Make sure SSH is installed then try again"
	echo
	exit;
fi

# Update config
sudo echo "KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1" >> /etc/ssh/sshd_config

# Restart SSH service
sudo systemctl restart ssh

echo "***SSH CONFIG UPDATED***"
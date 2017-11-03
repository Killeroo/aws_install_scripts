#!/bin/bash

# Adds the required ssh config lines to let mysql workbench ssh 
# into the instance
# Based on: https://serverfault.com/a/692131

# Check config file exists
if [ ! -f /etc/ssh/sshd_config ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@        SSH CONFIG FILE NOT FOUND!     @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "Make sure SSH is installed then try again."
	echo
	exit;
fi

# Update config
sudo echo "KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1" >> /etc/ssh/sshd_config

# Restart SSH service
sudo systemctl restart ssh

echo "> ssh config updated."
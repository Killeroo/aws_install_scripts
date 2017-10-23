#!/bin/bash

# Check if script is being run with bash
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "Please use 'bash fetch_password.sh to run the script"
	exit;
fi

key=$(bash $PWD/fetch_password.sh new-relic)
if [[ -z "${key// }" ]]; then
	echo "***NO NEW-RELIC KEY FOUND IN PASSWORDS.CONF***"
	echo "Please ensure a key is entered in src/password.conf and try again"
	exit
fi
echo $key
exit

# Add new-relic repo
echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | sudo tee /etc/apt/sources.list.d/newrelic.list

# Add new-relic repo key
wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -

# Update repos
sudo apt-get -y update

# Install new-relic
sudo apt-get -y install newrelic-sysmond

# fetch and add api key

#sudo nrsysmond-config --set license_key=$key

# Start new-relic service
#systemctl start newrelic-sysmond
#/etc/init.d/newrelic-sysmond start
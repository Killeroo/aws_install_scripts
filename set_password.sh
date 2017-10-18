#!/bin/bash

# Argument check 
if [ $# -ne 1 ]; then
	echo "Incorrect argument count:"
	echo "set_password [mysql] OR [account]"
	exit
fi

# Check password.conf exists
if [ ! -f $PWD/password.conf ]; then
	echo "***password.conf file could not be found***"
	echo "Please ensure this file exists in $PWD and try again"
	exit;
fi

# Fetch appropriate password
if [ "$1" == "mysql" ]; then
	password=$(grep 'mysql_password=' $PWD/password.conf | awk -F= '{ print  $2 }')
elif [ "$1" == "account" ]; then
	password=$(grep 'account_password=' $PWD/password.conf | awk -F= '{ print  $2 }')
else
	echo "Unrecognised argument: Please use either [mysql] OR [account]"
	exit
fi

expect_cmd=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$MYSQL\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

# Run expect command
echo "$expect_cmd"